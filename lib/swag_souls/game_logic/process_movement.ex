defmodule SwagSouls.GameLogic.ProcessMovement do
  alias SwagSouls.Players.Player

  @doc """
  Processes the input of a game map, desired coordinates and %SwagSouls.Players.Player{}.

  When the desired coordinates is a wall, it returns unmodified %SwagSouls.Players.Player{},
  effectively preventing the player to move to these coordinates.

  When the desired coordinates is a grass tile, it returns modified %SwagSouls.Players.Player{coordinates: new_coordinates}

  ## Example
    iex> SwagSouls.GameLogic.ProcessMovement.call(%{{0,1} => :wall}, %SwagSouls.Players.Player{name: "Bob", state: :alive, coordinates: {1,1}}, :left)
    %SwagSouls.Players.Player{name: "Bob", state: :alive, coordinates: {1,1}}

    iex> SwagSouls.GameLogic.ProcessMovement.call(%{{1,2} => {:grass, []}}, %SwagSouls.Players.Player{name: "Bob", state: :alive, coordinates: {1,1}}, :down)
    %SwagSouls.Players.Player{name: "Bob", state: :alive, coordinates: {1,2}}
  """
  def call(_map, %Player{state: :dead} = player, _direction), do: player

  @spec call(map(), Player.t(), atom()) :: Player.t()
  def call(map, player, direction) do
    player_x_position = elem(player.coordinates, 0)
    player_y_position = elem(player.coordinates, 1)

    case direction do
      :up    -> move(map, {player_x_position, player_y_position - 1}, player)
      :down  -> move(map, {player_x_position, player_y_position + 1}, player)
      :left  -> move(map, {player_x_position - 1, player_y_position}, player)
      :right -> move(map, {player_x_position + 1, player_y_position}, player)
      _      -> player
    end
  end

  defp move(map, new_coordinates, player) do
    case Map.get(map, new_coordinates) do
      :wall           -> player
      {:grass, []}    -> %Player{player | coordinates: new_coordinates}
      {:grass, [_|_]} -> %Player{player | coordinates: new_coordinates}
    end
  end
end
