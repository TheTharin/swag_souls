defmodule SwagSouls.Game.MapServer do
  use GenServer

  @spec start_link(map()) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  @spec init(map()) :: {:ok, map()}
  def init(_) do
    {:ok, SwagSouls.Game.Map.generate_layout()}
  end

  def get_map() do
    GenServer.call(__MODULE__, :get_map)
  end

  def get_random_grass_tile() do
    GenServer.call(__MODULE__, :get_random_grass_tile)
  end

  @impl true
  def handle_call(:get_map, _from, map) do
    {:reply, map, map}
  end

  def handle_call(:get_random_grass_tile, _from, map) do
    {:reply, SwagSouls.Game.Map.get_random_grass_tile(map), map}
  end
end
