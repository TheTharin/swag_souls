use Mix.Config

config :swag_souls, SwagSoulsWeb.Endpoint,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :swag_souls, max_width: 30
config :swag_souls, max_height: 30

config :logger, level: :info

import_config "prod.secret.exs"
