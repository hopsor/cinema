import Config

# Do not print debug messages in production
config :logger, level: :info

config :multiplex, MultiplexWeb.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json"

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: Multiplex.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
