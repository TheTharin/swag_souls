use Mix.Config

config :swag_souls, SwagSoulsWeb.Endpoint,
  url: [host: "swag-souls.gigalixirapp.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  check_origin: ["//swag-souls.gigalixirapp.com"]

config :swag_souls, max_width: 30
config :swag_souls, max_height: 30

config :logger, level: :info

import_config "prod.secret.exs"
