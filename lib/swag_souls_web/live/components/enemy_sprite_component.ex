defmodule EnemySpriteComponent do
  use Surface.Component

  prop player_state, :atom, required: true
  prop player_name, :string, required: true
  def render(assigns) do
    ~F"""
    {#case @player_state}
      {#match :alive}
        <div class="sprite" id="enemySprite">
          <img src="/images/enemy_sprite.png" width="100px" height="100px"/>
          <p class="name enemyName">{@player_name}</p>
        </div>
      {#match :dead}
        <div class="sprite" id="enemyDeadSprite">
          <img src="/images/enemy_dead_sprite.png" width="100px" height="100px"/>
          <p class="name enemyDeadName">{@player_name}</p>
        </div>
    {/case}
    """
  end
end
