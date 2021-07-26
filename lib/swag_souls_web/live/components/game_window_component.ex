defmodule GameWindowComponent do
  use Surface.Component

  prop max_height, :integer, required: true
  prop max_width,  :integer, required: true
  prop map,        :map,     required: true
  prop name,       :string,  required: true

  def render(assigns) do
    ~F"""
    <div id="gameWindow" phx-window-keyup="perform_action">
      {#for y <- (0..@max_height)}
        <div class="gameTilesRow">
          {#for x <- (0..@max_width)}
            {#case Map.get(@map, {x, y})}
              {#match :wall}
                <WallTileComponent id={"#{x}_#{y}"} />
              {#match {:grass, []}}
                <GrassTileComponent name={@name} id={"#{x}_#{y}"}/>
              {#match {:grass, [_|_] = players}}
                <GrassTileComponent name={@name} players={players} id={"#{x}_#{y}"}/>
            {/case}
          {/for}
        </div>
      {/for}
    </div>
    """
  end
end
