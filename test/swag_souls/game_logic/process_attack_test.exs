defmodule SwagSouls.GameLogic.ProcessAttackTest do
  use ExUnit.Case
  doctest SwagSouls.GameLogic.ProcessAttack

  alias SwagSouls.GameLogic.ProcessAttack

  alias SwagSouls.Players.Player

  describe "#call/2" do
    test "kills defending player across down-right" do
      player1 = %Player{name: "A", coordinates: {1,1}, state: :alive}
      player2 = %Player{name: "B", coordinates: {2,2}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :dead}
    end

    test "kills defending player across down-left" do
      player1 = %Player{name: "A", coordinates: {1,1}, state: :alive}
      player2 = %Player{name: "B", coordinates: {0,2}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :dead}
    end

    test "kills defending player across up-right" do
      player1 = %Player{name: "A", coordinates: {1,1}, state: :alive}
      player2 = %Player{name: "B", coordinates: {2,0}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :dead}
    end

    test "kills defending player across up-left" do
      player1 = %Player{name: "A", coordinates: {1,1}, state: :alive}
      player2 = %Player{name: "B", coordinates: {0,0}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :dead}
    end

    test "kills defending player above" do
      player1 = %Player{name: "A", coordinates: {1,1}, state: :alive}
      player2 = %Player{name: "B", coordinates: {1,0}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :dead}
    end

    test "kills defending player below" do
      player1 = %Player{name: "A", coordinates: {1,1}, state: :alive}
      player2 = %Player{name: "B", coordinates: {1,2}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :dead}
    end

    test "kills defending player to the right" do
      player1 = %Player{name: "A", coordinates: {1,1}, state: :alive}
      player2 = %Player{name: "B", coordinates: {2,1}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :dead}
    end

    test "kills defending player to the left" do
      player1 = %Player{name: "A", coordinates: {1,1}, state: :alive}
      player2 = %Player{name: "B", coordinates: {0,1}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :dead}
    end

    test "kills defending player on the same tile" do
      player1 = %Player{name: "A", coordinates: {1,1}, state: :alive}
      player2 = %Player{name: "B", coordinates: {1,1}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :dead}
    end

    test "doesn't kill defending player two tiles to the right" do
      player1 = %Player{name: "A", coordinates: {1,1}, state: :alive}
      player2 = %Player{name: "B", coordinates: {3,1}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :alive}
    end

    test "doesn't kill defending player two tiles to the left" do
      player1 = %Player{name: "A", coordinates: {2,1}, state: :alive}
      player2 = %Player{name: "B", coordinates: {0,1}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :alive}
    end

    test "doesn't kill defending player two tiles down" do
      player1 = %Player{name: "A", coordinates: {1,1}, state: :alive}
      player2 = %Player{name: "B", coordinates: {1,3}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :alive}
    end

    test "doesn't kill defending player two tiles up" do
      player1 = %Player{name: "A", coordinates: {1,2}, state: :alive}
      player2 = %Player{name: "B", coordinates: {1,0}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :alive}
    end

    test "doesn't kill defending player two across" do
      player1 = %Player{name: "A", coordinates: {2,2}, state: :alive}
      player2 = %Player{name: "B", coordinates: {0,0}, state: :alive}

      assert ProcessAttack.call(player1, player2) == %Player{player2 | state: :alive}
    end
  end
end
