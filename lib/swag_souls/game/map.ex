defmodule SwagSouls.Game.Map do
  @max_width Application.get_env(:swag_souls, :max_width)
  @max_height Application.get_env(:swag_souls, :max_height)

  @doc """
  Generates game map layout as a map, where key is a coordinate vector {x, y} and value is
  either :wall or :grass.

  Currently the game map is a simple rectangle of :grass surrounded by :walls from all 4 sides.

  ## Example
    iex> SwagSouls.Game.Map.generate_layout()
    %{
      {0,0} => :wall, {1,0} => :wall,        {2,0} => :wall,        {3,0} => :wall,
      {0,1} => :wall, {1,1} => {:grass, []}, {2,1} => {:grass, []}, {3,1} => :wall,
      {0,2} => :wall, {1,2} => {:grass, []}, {2,2} => {:grass, []}, {3,2} => :wall,
      {0,3} => :wall, {1,3} => :wall,        {2,3} => :wall,        {3,3} => :wall,
    }
  """
  @spec generate_layout :: map()
  def generate_layout() do
    Enum.reduce((0..@max_height - 1), %{}, fn y, map ->
      Enum.reduce((0..@max_width - 1), map, fn x, map ->
        Map.put(map, {x, y}, calculate_tile_type(x, y))
      end)
    end)
  end

  @doc """
  Gets random grass tile on a given map.

  ## Example
  iex> SwagSouls.Game.Map.get_random_grass_tile(%{ {0, 0} => :wall, {1, 1} => {:grass, []} })
  {1, 1}
  """
  @spec get_random_grass_tile(map()) :: {Integer, Integer}
  def get_random_grass_tile(map) do
    x = Enum.random((1..@max_width - 2))
    y = Enum.random((1..@max_height - 2))

    case Map.get(map, {x, y}) do
      {:grass, []} -> {x, y}
      {:grass, [_|_]} -> {x, y}
      :wall -> get_random_grass_tile(map)
      _ -> get_random_grass_tile(map)
    end
  end

  @spec calculate_tile_type(Integer, Integer) :: atom()
  defp calculate_tile_type(height, width) do
    height_constraint = @max_height - 1
    width_constraint = @max_width - 1

    case {height, width} do
      {0, _width}                  -> :wall
      {^height_constraint, _width} -> :wall
      {_height, 0}                 -> :wall
      {_height, ^width_constraint} -> :wall
      _                            -> {:grass, []}
    end
  end
end
