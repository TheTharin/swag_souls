defmodule SwagSouls.Game do
  use Supervisor

  alias SwagSouls.Players.Player
  alias SwagSouls.Game.{MapServer, PlayerRegistry, PlayerServer, TickHandler}

  def start_link(_) do
    Supervisor.start_link(__MODULE__, nil)
  end

  def init(_) do
    Supervisor.init([PlayerRegistry,
                     MapServer,
                     PlayerServer,
                     TickHandler],
                     strategy: :one_for_one)
  end

  @spec add_player(binary()) :: {:error, :player_exists} | {:ok, pid()} | {:ok, pid(), any()}
  def add_player(name) do
    case Registry.lookup(PlayerRegistry, name) do
      [{_pid, _something}] -> {:error, :player_exists}
      _ -> PlayerServer.add_player(%Player{name: name,
                                           state: :alive,
                                           coordinates: get_random_coordinates()})
    end
  end

  def collect_current_state() do
    map = MapServer.get_map()
    Enum.reduce(DynamicSupervisor.which_children(PlayerServer), map, fn child, map ->
      {_undefined, pid, _type, [_module]} = child
      player_struct = SwagSouls.Game.Player.get_player(pid)
      {tile_type, players_list} = Map.get(map, player_struct.coordinates)
      Map.put(map, player_struct.coordinates, {tile_type, [player_struct | players_list]})
    end)
  end

  @spec move_player(binary(), atom()) :: :ok
  def move_player(name, direction) do
    [{player_pid, _}] = Registry.lookup(PlayerRegistry, name)

    SwagSouls.Game.Player.move(player_pid, direction)
  end

  def perform_attack(name) do
    [{player_pid, _}] = Registry.lookup(PlayerRegistry, name)

    SwagSouls.Game.Player.perform_attack(player_pid)
  end

  defp get_random_coordinates() do
    MapServer.get_random_grass_tile()
  end
end
