defmodule SwagSouls.Game.PlayerServer do
  use DynamicSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  @spec add_player(SwagSouls.Players.Player.t()) :: :ignore | {:error, any} | {:ok, pid} | {:ok, pid, any}
  def add_player(player) do
    child_spec = {SwagSouls.Game.Player, player}

    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end
end
