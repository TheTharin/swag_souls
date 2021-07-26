defmodule GameWindowComponent do
  use SwagSoulsWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id="gameWindow" phx-window-keyup="perform_action">
      <%= for y <- (0..Application.get_env(:swag_souls, :max_height) - 1) do %>
        <div class="gameTilesRow">
          <%= for x <- (0..Application.get_env(:swag_souls, :max_width) - 1) do %>
            <%= case Map.get(@map, {x, y}) do
                  :wall                     -> live_component WallTileComponent, coordinates: {x, y}
                  {:grass, []}              -> live_component GrassTileComponent, players: [],      coordinates: {x, y}, name: @name
                  {:grass, [_|_] = players} -> live_component GrassTileComponent, players: players, coordinates: {x, y}, name: @name
                end %>
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end
end
