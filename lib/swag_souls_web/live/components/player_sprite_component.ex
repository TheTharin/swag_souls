defmodule PlayerSpriteComponent do
  use SwagSoulsWeb, :live_component

  def render(assigns) do
    case Map.get(assigns, :player).state do
      :alive -> ~L"""
                <img class="sprite" id="playerSprite" src="/images/player_sprite.png" width=100px height=100px/>
                """
      :dead  -> ~L"""
                <img class="sprite" id="playerSprite" src="/images/player_dead_sprite.png" width=100px height=100px/>
                """
    end
  end
end
