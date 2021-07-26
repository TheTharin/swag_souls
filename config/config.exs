use Mix.Config

config :swag_souls, SwagSoulsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bZV2WP5coUJR/aI2S5WWaQuG+WvmHYxJo9kph3oOqHWKdi6Ka0COdXCpmpF0gh7I",
  render_errors: [view: SwagSoulsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SwagSouls.PubSub,
  live_view: [signing_salt: "MGjBsle5"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
