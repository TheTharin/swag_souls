defmodule SwagSouls.Game.MapServerTest do
  use ExUnit.Case

  describe "#get_map/0" do
    test "it returns game_map map" do
      {:ok, _game_system} = start_supervised(SwagSouls.Game)
      assert SwagSouls.Game.MapServer.get_map() ==
        %{
          {0,0} => :wall, {1,0} => :wall,        {2,0} => :wall,        {3,0} => :wall,
          {0,1} => :wall, {1,1} => {:grass, []}, {2,1} => {:grass, []}, {3,1} => :wall,
          {0,2} => :wall, {1,2} => {:grass, []}, {2,2} => {:grass, []}, {3,2} => :wall,
          {0,3} => :wall, {1,3} => :wall,        {2,3} => :wall,        {3,3} => :wall,
        }
    end
  end
end
