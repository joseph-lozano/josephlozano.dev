title: "Speedrunning a Phoenix Elixir Deployment to production (without a PaaS)"
description: "Deploying Elixir and Phoenix applications used to the be one the most challenging parsts of the language. Now its among the easiest."

---

_Part 1 in the Phoenix SaaS series_

# Speedrunning a Phoenix Elixir Deployment to production (without a PaaS)

There are many great Platform as a Service (PaaS) providers for Phoenix. [Render](https://render.com), and [Fly.io](https://fly.io) especially, and they have great documentation for getting up and running. PaaS providers have lots of benefits, including ease of deployments, managed database with automatic backups, and more. But using a plain VPS can get you more power or a lot less money. This is especailly true if you are running multiple apps.

In this post, we are going to go from (almost) zero to deployment using Hetzner, but you can follow along using other cloud providers, such as [Linode](https://linode.com), [Digital Ocean](https://digitalocean.com), or even AWS or GCP. I chose Hetzner for their great reviews, and low price.

I am assuming familiarity with the command line and git. If you get stuck at point, just shoot me an [email](mailto:me@josephlozano.dev).

## Get a server

Create an account at https://cloud.hetzner.com, and create a server in a region near you. I chose Ashburn, VA, Ubuntu 22.04, Standard, and the cheapest option CPX11. I already had an ssh set up (for github, so I uploaded the public key to Hetzner and used that).

![Hetzer create server page](/images/2022-06-10-hetzner.png)
After you click "Create and Buy Now", your server will take a few seconds to provision. Once it is done provisioning, take note of the IP address. We will use it later.

## Setup DNS

This could really be done at the end, but since DNS propagation could take some time, better to just get it out of the way early. Since I already own `josephlozano.dev`, I am just going to use a subdomain `saas.josephlozano.dev`. I use namecheap, so I am going to set up a A record, pointing `saas` to the IP address of my server from Hetzner.

## Setting up our user

```language-shell
# Your machine
# Replace id_ed25519 with your SSH private key,
# and 5.161.109.211 with the IP address of the server you provisioned
ssh -i id_ed25519 root@5.161.109.211
```

After this command, you will be in a terminal prompt on your production machine. To keep things simple, all console commands with begin with `# Your machine` or `# Prod machine`

After we shell into the prod machine, we don't want to run things as root, so we create a `deployer` user, and add them to the `sudo` group.

```language-shell
# Prod machine
adduser deployer # you will be prompted to pick a password.
usermod -aG sudo deployer
exit # exit back to your machine
```

## Phoenix Application Set Up

If Elixir and Phoenix are not already installed on your machine, install them now. [Instructions](https://hexdocs.pm/phoenix/installation.html).

```language-shell
# Your machine
yes | mix phx.new saas_starter --verbose
cd saas_starter
git init
git add -A
git commit -am "init"
```

Create a repo in your git repository of choice, such as Github, or Gitlab.

Now here is the real magic.

```language-shell
# Your machine
mix phx.gen.release --docker # 🤯
```

This created a few files, the most important of which is the `Dockerfile`.

Lets also create a file called `docker-compose.yaml`

```language-yaml
# docker-compose.yaml
services:
  web:
    build: .
    env_file: ".env"
    ports:
      - "4000:4000"
    depends_on:
      - "postgres"
  postgres:
    image: "postgres:14.2-bullseye"
    env_file: ".env"
    volumes:
      - "postgres:/var/lib/postgresql/data"
volumes:
  postgres: {}
```

Also, create a `.env` file, which will hold your applicaton secrets. **Make sure you add this file to `.gitignore`**. You can generate a secret key base with `mix phx.gen.secret`. Since this file is ignored by git, you'll want to add it (with different secrets) to both your development machine, and the prod machine.

```language-shell
# .env
SECRET_KEY_BASE=7nHKkUx59EMydLAIhzxUJ0IBuBO1NImqeczRBnqbb2Z1fi71CYrgCVqiXLOgXaA3
PHX_HOST="saas.josephlozano.dev"
POSTGRES_USER=saas_starter
POSTGRES_PASSWORD=password
POSTGRES_DB=saas_starter
DATABASE_URL=postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/${POSTGRES_DB}
```

Now that we've created our release, and `docker-compose.yaml` file, we can commit.

```language-shell
# Your machine
# make sure .env is ignored by git.
git add -A
git commit -m "Dockerize"
git push
```

Now, bring it all together on your development machine. Run `docker-compose up --build`. Because we are forwarding port 4000 from Docker, we just visit https://localhost:4000 to see our app running in Docker.

## Ready, Set, Deploy

Now you can ssh into the production machine as `deployer`.

```language-shell
# Your machine
# you will be prompted for the user password you created earlier
ssh deployer@5.161.109.211
```

```language-shell
# Prod machine (as deployer)
sudo apt update
sudo apt install docker docker-compose
# replace with the URL of your repo
git clone https://github.com/joseph-lozano/saas_starter
cd saas_starter
# create a .env file with secrets, just like on your machine
vi .env # you can also use nano if you are not comfortable with vi
# One last step before we can run docker is to add the current $USER to docker groups
sudo usermod -aG docker $USER
```

You will then have to log out and log back in
After all that is done, just run

```language-shell
# Prod machine (as deployer)
docker-compose up --build -d
```

Now your app is officially running in production! The last step is set up a reverse proxy. Because our app is running on port 4000, a reverse proxy will direct traffic from outside our production machine (aka from the internet) to our application. For this, we will use [Caddy](https://caddyserver.com)

> Caddy 2 is a powerful, enterprise-ready, open source web server with automatic HTTPS written in Go

Automatic HTTPS via Let's Encrypt is a killer feature over something like Nginx.

The [installation instructions](https://caddyserver.com/docs/install#debian-ubuntu-raspbian) at the time of writing are:

```language-shell
# Prod machine
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
```

This will download and start Caddy, but we need to update the configuration to set up the reverse proxy:

```language-shell
# Prod machine
sudo vi /etc/caddy/Caddyfile # or nano
```

Edit your Caddyfile to look like the following (replacing the url):

```
saas.josephlozano.dev {
  reverse_proxy 127.0.0.1:4000
}
```

Now, we need to restart Caddy for these changes to take effect.

```language-shell
# Prod machine
systemctl reload caddy
```

That's it! Our side is now live in production! Check it out at https://saas.josephlozano.dev!
