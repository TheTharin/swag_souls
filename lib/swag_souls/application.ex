defmodule SwagSouls.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, [name: SwagSouls.PubSub, adapter: Phoenix.PubSub.PG2]},
      # Start the Telemetry supervisor
      SwagSoulsWeb.Telemetry,
      # Start the Endpoint (http/https)
      SwagSoulsWeb.Endpoint,
      # Start the Game
      SwagSouls.Game,
      # Start LiveView monitor
      SwagSoulsWeb.LiveMonitor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SwagSouls.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SwagSoulsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
