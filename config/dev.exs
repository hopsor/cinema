import Config

# Do not include metadata nor timestamps in development logs
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
config :logger, :console, format: "[$level] $message\n"

# Configure your database
# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we can use it
# to bundle .js and .css sources.
# Binding to loopback ipv4 address prevents access from other machines.
config :multiplex, Multiplex.EventStore,
  serializer: EventStore.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "eventstore",
  hostname: "localhost"

config :multiplex, Multiplex.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "multiplex_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :multiplex, MultiplexWeb.Endpoint,
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "zcWbgCuZVOyHgog0nLrY2Oi5Q11edt/arZT1IEEfSc7YUWXr1Ryu6smcFtYLo2N4",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:multiplex, ~w(--sourcemap=inline --watch)]},
    # Watch static and templates for browser reloading.
    tailwind: {Tailwind, :install_and_run, [:multiplex, ~w(--watch)]}
  ]

config :multiplex, MultiplexWeb.Endpoint,
  # ## SSL Support
  #
  # In order to use HTTPS in development, a self-signed
  # certificate can be generated by running the following
  # Mix task:
  #
  #     mix phx.gen.cert
  #
  # Run `mix help phx.gen.cert` for more information.
  live_reload: [
    patterns: [
      # Enable dev routes for dashboard and mailbox
      #
      # The `http:` config above can be replaced with:
      #
      #     https: [
      #       port: 4001,
      # Initialize plugs at runtime for faster development compilation
      #
      # If desired, both `http:` and `https:` keys can be
      # configured to run both http and https servers on
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/multiplex_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

config :multiplex, dev_routes: true
config :multiplex, event_stores: [Multiplex.EventStore]

config :phoenix, :plug_init_mode, :runtime

# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

config :phoenix_live_view,
  # Include HEEx debug annotations as HTML comments in rendered markup
  debug_heex_annotations: true,
  # Enable helpful, but potentially expensive runtime checks
  enable_expensive_runtime_checks: true

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Set a higher stacktrace during development. Avoid configuring such
# different ports.
