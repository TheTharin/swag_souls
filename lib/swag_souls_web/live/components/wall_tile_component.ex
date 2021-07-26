defmodule WallTileComponent do
  use SwagSoulsWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="gameTile wallTile" id="<%= elem(@coordinates, 0) %>_<%= elem(@coordinates, 1) %>">
    </div>
    """
  end
end
