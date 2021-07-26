defmodule GameTest do
  use ExUnit.Case

  alias SwagSouls.Players.Player
  alias SwagSouls.Game.{PlayerRegistry, PlayerServer, MapServer}

  describe "#add_player/1" do
    test "adds player with given name" do
      {:ok, _game_system} = start_supervised(SwagSouls.Game)

      SwagSouls.Game.add_player("Bilbo")

      [{player_pid, _}] = Registry.lookup(PlayerRegistry, "Bilbo")

      assert SwagSouls.Game.Player.get_player(player_pid).name == "Bilbo"
    end
  end

  describe "#collect_current_state/0" do
    test "returns a map with players placed at their coordinates" do
      {:ok, _game_system} = start_supervised(SwagSouls.Game)

      player1 = %Player{name: "Bilbo", state: :alive, coordinates: {1, 1}}
      player2 = %Player{name: "Frodo", state: :alive, coordinates: {2, 2}}
      PlayerServer.add_player(player1)
      PlayerServer.add_player(player2)

      assert SwagSouls.Game.collect_current_state() ==
        %{
          {0,0} => :wall, {1,0} => :wall,               {2,0} => :wall,               {3,0} => :wall,
          {0,1} => :wall, {1,1} => {:grass, [player1]}, {2,1} => {:grass, []},        {3,1} => :wall,
          {0,2} => :wall, {1,2} => {:grass, []},        {2,2} => {:grass, [player2]}, {3,2} => :wall,
          {0,3} => :wall, {1,3} => :wall,               {2,3} => :wall,               {3,3} => :wall,
        }
    end
  end
end
