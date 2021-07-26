defmodule PlayerSpriteComponent do
  use Surface.Component

  prop player_state, :atom, required: true
  def render(assigns) do
    ~F"""
    {#case @player_state}
      {#match :alive}
        <img class="sprite" id="playerSprite" src="/images/player_sprite.png" width="100px" height="100px"/>
      {#match :dead}
        <img class="sprite" id="playerSprite" src="/images/player_dead_sprite.png" width="100px" height="100px"/>
    {/case}
    """
  end
end
