title: "Zero to production with Phoenix in just 7 lines."
description: "Deploying Elixir and Phoenix applications used to the be one the most challenging parsts of the language. Now its among the easiest."

---

# Erat et mitto telorum

## Erat litus vultus amoris quae iam petiere

Lorem markdownum, dictis, summae? Est vestris latoque tumescere contemnere
saepe, vertice vidi est inplebo [ventis](http://tamque.net/sucis) cerata!

```language-elixir
defrecord Person, first_name: nil, last_name: "Dudington" do
  def name record do # huh ?
    "#{record.first_name} #{record.last_name}"
  end
end

defrecord User, name: "José", age: 25

guy = Person.new first_name: "Guy"
guy.name

defmodule ListServer do
  @moduledoc """
  This module provides an easy to use ListServer, useful for keeping
  lists of things.
  """
  use GenServer.Behaviour
  alias Foo.Bar

  ### Public API
  @doc """
  Starts and links a new ListServer, returning {:ok, pid}

  ## Example

    iex> {:ok, pid} = ListServer.start_link

  """
  def start_link do
    :gen_server.start_link({:local, :list}, __MODULE__, [], [])
  end

  ### GenServer API
  def init(list) do
    {:ok, list}
  end

  # Clear the list
  def handle_cast :clear, list do
    {:noreply, []}
  end
end

{:ok, pid} = ListServer.start_link
pid <- {:foo, "bar"}

greeter = fn(x) -> IO.puts "hey #{x}" end
greeter.("Bob")
```

Quid et vertice expers; dum Milon arbore. Quas aera. Sua hasta cura ore, arma
est Ossaque, veniens mecum non, tantumque. Quod vocalia factum invida equam
pater inde, corpore non sprevere neutra; sanguis. Ensis et diva [laceri sum
te](http://tuentur.org/praesepia-quas) postarum [leto](http://www.aglauros.net/)
cura virginitate.

1. Fronde es pius
2. Fertur metu
3. Nunc tibi equus ferox ignis sibi ausa
4. Fulgentia sepulcro omen in signatur latus miserrima

## Exhortatus tellus Diana supplex ira saepe cum

Paternos suae limine tauri tibia quoque quattuor mitissima tardi capillos viva,
ego. Ad rigori portabat miraris; praeduraque elige, sed mutastis viam
germanamque pastoribus saepe et ardent quod.

1. Tremuloque mixto sed aeratae petis
2. Suas fudi morte
3. Vestras sed te dixit
4. Lapides virtutem luporum
5. Fata ut mare
6. Dum veros vim debita audit

Claudit per vultus, fuit sua habet est hanc, ipsum quod tenues cinctam, mentem.
Stridentemque ergo nominat vocatur quos saepibus fraternis laborat adstitit, in
plura pugno misso, pertulerint dici flectant. Post sed: veniam mox deus
Deiphobum obstat blanditiis in in caput premitur cepere die nemorum et totumque
mare, nocent. Audes dolet, mei pars est; Turni sub corpus versus inclusum
[superorum](http://virga.org/rabiemdiruerent.html) incumbens iaculum. Frondes
Salamis vocant Cepheus quam, utque Nonacrinas falsa pete alit super futuri de
distincta iurant aversa offensa genuisse desit!

- Donec eventuque constitit perde umquam loqui
- Ipse Cereris nemorosam repugnat et oreada caerulaque
- Senta habenas cremabit certet rogantem venis exiguamque
- Modulatur saepe positis digna nova Thyoneus
- Tamen parari

Narcissum iunctam, vulnere in agmen, dominus consedit genis frater. Nisi namque,
valvis sic harenas se Achille medium dixit, plebis fert quod meliora sulcum ad
sumite et. Lupis superis est hac tempore perque inmanibus aut sive; huc!
