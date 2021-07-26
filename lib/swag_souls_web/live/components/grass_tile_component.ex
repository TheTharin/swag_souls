defmodule GrassTileComponent do
  use Surface.Component

  prop players, :list, required: false
  prop id, :string, required: true
  prop name, :string, required: true

  def render(assigns) do
    ~F"""
    <div class="gameTile grassTile" id={@id}>
      {#if @players}
        {#for player <- @players}
          {#if @name == player.name}
            <PlayerSpriteComponent player_state={player.state}/>
          {#else}
            <EnemySpriteComponent player_name={player.name} player_state={player.state}/>
          {/if}
        {/for}
      {/if}
    </div>
    """
  end
end
