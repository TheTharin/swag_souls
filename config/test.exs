use Mix.Config

config :swag_souls, SwagSoulsWeb.Endpoint,
  http: [port: 4002],
  server: false

config :swag_souls, max_width: 4
config :swag_souls, max_height: 4

config :logger, level: :warn
