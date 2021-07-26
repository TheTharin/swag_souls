defmodule SwagSouls.Game.TickHandler do
  use GenServer

  alias SwagSouls.Game

  @tickrate 10

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    schedule()
    {:ok, nil}
  end

  def handle_info(:broadcast_map_state, _) do
    schedule()
    state = Game.collect_current_state()
    SwagSoulsWeb.Endpoint.broadcast!("game_updates", "update_map_state", state)

    {:noreply, nil}
  end

  defp schedule(), do: Process.send_after(self(), :broadcast_map_state, div(1000, @tickrate))
end
