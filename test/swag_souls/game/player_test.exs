defmodule SwagSouls.Game.PlayerTest do
  use ExUnit.Case

  alias SwagSouls.Players.Player
  alias SwagSouls.Game.{PlayerServer, PlayerRegistry, MapServer}
  alias SwagSouls.Game.Player, as: GamePlayer

  describe "#get_player/1" do
    test "it returns player struct" do
      {:ok, _game_system} = start_supervised(SwagSouls.Game)

      player = %Player{name: "Bob", state: :alive, coordinates: {1, 1}}

      {:ok, player_pid} = PlayerServer.add_player(player)
      assert GamePlayer.get_player(player_pid) == player
    end
  end

  describe "#perform_attack/1" do
    test "it attacks all the players around" do
      {:ok, _game_system} = start_supervised(SwagSouls.Game)

      player1 = %Player{name: "Bob", state: :alive, coordinates: {1, 1}}
      player2 = %Player{name: "Mitch", state: :alive, coordinates: {2, 1}}
      player3 = %Player{name: "Karen", state: :alive, coordinates: {1, 2}}
      player4 = %Player{name: "Sara", state: :alive, coordinates: {2, 3}}

      Enum.each([player1, player2, player3, player4], fn player ->
        PlayerServer.add_player(player)
      end)

      [{player1_pid, _}] = Registry.lookup(PlayerRegistry, "Bob")
      [{player2_pid, _}] = Registry.lookup(PlayerRegistry, "Mitch")
      [{player3_pid, _}] = Registry.lookup(PlayerRegistry, "Karen")
      [{player4_pid, _}] = Registry.lookup(PlayerRegistry, "Sara")

      GamePlayer.perform_attack(player1_pid)

      assert GamePlayer.get_player(player1_pid) == player1
      assert GamePlayer.get_player(player2_pid) == %Player{player2 | state: :dead}
      assert GamePlayer.get_player(player3_pid) == %Player{player3 | state: :dead}
      assert GamePlayer.get_player(player4_pid) == %Player{player4 | state: :alive}
    end
  end

  describe "#attack_enemy/2" do
    test "it attacks enemy" do
      {:ok, _game_system} = start_supervised(SwagSouls.Game)

      player1 = %Player{name: "Bob", state: :alive, coordinates: {1, 1}}
      player2 = %Player{name: "Mitch", state: :alive, coordinates: {2, 1}}

      PlayerServer.add_player(player1)
      PlayerServer.add_player(player2)

      [{player2_pid, _}] = Registry.lookup(PlayerRegistry, "Mitch")

      GamePlayer.attack_enemy(player2_pid, player1)

      assert GamePlayer.get_player(player2_pid) == %Player{player2 | state: :dead}
    end
  end

  describe "#move/2" do
    test "it moves the player down" do
      {:ok, _game_system} = start_supervised(SwagSouls.Game)

      player = %Player{name: "Bob", state: :alive, coordinates: {1, 1}}
      PlayerServer.add_player(player)
      [{player_pid, _}] = Registry.lookup(PlayerRegistry, "Bob")

      GamePlayer.move(player_pid, :down)
      assert GamePlayer.get_player(player_pid) == %Player{player | coordinates: {1, 2}}
    end

    test "it moves the player down, even if another player is already there" do
      {:ok, _game_system} = start_supervised(SwagSouls.Game)

      player1 = %Player{name: "Bob", state: :alive, coordinates: {1, 1}}
      player2 = %Player{name: "Mitch", state: :alive, coordinates: {1, 2}}

      PlayerServer.add_player(player1)
      PlayerServer.add_player(player2)

      [{player1_pid, _}] = Registry.lookup(PlayerRegistry, "Bob")
      [{player2_pid, _}] = Registry.lookup(PlayerRegistry, "Mitch")

      GamePlayer.move(player1_pid, :down)

      assert GamePlayer.get_player(player1_pid) == %Player{player1 | coordinates: {1, 2}}
      assert GamePlayer.get_player(player2_pid) == player2
    end

    test "it doesn't let player move into a wall" do
      {:ok, _game_system} = start_supervised(SwagSouls.Game)

      player = %Player{name: "Bob", state: :alive, coordinates: {1, 1}}

      PlayerServer.add_player(player)

      [{player_pid, _}] = Registry.lookup(PlayerRegistry, "Bob")

      GamePlayer.move(player_pid, {0, 1})

      assert GamePlayer.get_player(player_pid) == player
    end
  end
end
