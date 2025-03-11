import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used

# Print only warnings and errors during test
config :logger, level: :warning

# In test we don't send emails
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :multiplex, Multiplex.Mailer, adapter: Swoosh.Adapters.Test

config :multiplex, Multiplex.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "multiplex_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  # We don't run a server during test. If one is required,
  # you can enable the server option below.
  pool_size: System.schedulers_online() * 2

config :multiplex, MultiplexWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "l6cwrErNE1wqLwJUGmAsexevean8ScB3GF4hVhh2sojlIMtmqhWTI64Bk78w/mF5",
  server: false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false
