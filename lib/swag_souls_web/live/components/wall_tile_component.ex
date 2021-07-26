defmodule WallTileComponent do
  use Surface.Component

  prop id, :string, required: true

  def render(assigns) do
    ~F"""
    <div class="gameTile wallTile" id={@id}>
    </div>
    """
  end
end
