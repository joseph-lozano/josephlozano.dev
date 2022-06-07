import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jl_dev, JLDevWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Bhwg4OPRYYSZYskNmtvP8IxN+1LbrYLIP2Kty5GQDltx/rgiJzAj63KiR9nqfYCh",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
