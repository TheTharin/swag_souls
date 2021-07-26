defmodule EnemySpriteComponent do
  use SwagSoulsWeb, :live_component

  def render(assigns) do
    case Map.get(assigns, :player).state do
      :alive -> ~L"""
                <img class="sprite" id="enemySprite" src="/images/enemy_sprite.png" width=100px height=100px/>
                <p class="name enemyName"><%=@player.name%></p>
                """
      :dead  -> ~L"""
                <img class="sprite" id="enemySprite" src="/images/enemy_dead_sprite.png" width=100px height=100px/>
                <p class="name deadEnemyName"><%=@player.name%></p>
                """
    end
  end
end
