defmodule GrassTileComponent do
  use SwagSoulsWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="gameTile grassTile" id="<%= elem(@coordinates, 0) %>_<%= elem(@coordinates, 1) %>">
      <%= for player <- @players do %>
        <%= if player.name == @name do %>
          <%= live_component PlayerSpriteComponent, player: player %>
        <% else %>
          <%= live_component EnemySpriteComponent, player: player %>
        <% end %>
      <% end %>
    </div>
    """
  end
end
