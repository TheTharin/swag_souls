defmodule SwagSouls.GameLogic.ProcessAttack do
  alias SwagSouls.Players.Player

  @doc """
  Checks whether the two players' coordinates are adjacent using Manhattan Distance.
  If they are - kills the defending player and return it's struct.
  If they are not - just returns the defending player's struct.

  ## Example
    iex> player1 = %SwagSouls.Players.Player{name: "A", coordinates: {0,1}, state: :alive}
    iex> player2 = %SwagSouls.Players.Player{name: "B", coordinates: {0,2}, state: :alive}
    iex> SwagSouls.GameLogic.ProcessAttack.call(player1, player2)
    %SwagSouls.Players.Player{name: "B", coordinates: {0,2}, state: :dead}

    iex> player1 = %SwagSouls.Players.Player{name: "A", coordinates: {0,1}, state: :alive}
    iex> player2 = %SwagSouls.Players.Player{name: "B", coordinates: {0,3}, state: :alive}
    iex> SwagSouls.GameLogic.ProcessAttack.call(player1, player2)
    %SwagSouls.Players.Player{name: "B", coordinates: {0,3}, state: :alive}
  """
  @spec call(Player.t(), Player.t()) :: Player.t()
  def call(%Player{state: :dead}, defending_player), do: defending_player
  def call(_attacking_player, %Player{state: :dead} = defending_player), do: defending_player

  def call(attacking_player, defending_player) do
    case are_adjacent?(attacking_player, defending_player) do
      true -> %Player{defending_player | state: :dead}
      false -> defending_player
    end
  end

  defp are_adjacent?(attacking_player, defending_player) do
    dx = elem(attacking_player.coordinates, 0) - elem(defending_player.coordinates, 0) |> abs()
    dy = elem(attacking_player.coordinates, 1) - elem(defending_player.coordinates, 1) |> abs()

    case dx + dy do
      0 -> true
      1 -> true
      2 -> are_adjacent_diagonal?(dx, dy)
      _ -> false
    end
  end

  defp are_adjacent_diagonal?(dx, dy) do
    case {dx, dy} do
      {1, 1} -> true
      _      -> false
    end
  end
end
