defmodule SwagSoulsWeb.PageLive do
  use SwagSoulsWeb, :live_view
  require IEx

  alias SwagSouls.Game

  @impl true
  def mount(_params, _session, socket) do
    SwagSoulsWeb.Endpoint.subscribe("game_updates")
    max_width  = Application.get_env(:swag_souls, :max_width) - 1
    max_height = Application.get_env(:swag_souls, :max_height) - 1
    {:ok, assign(socket, name: nil, max_height: max_height, max_width: max_width)}
  end

  @impl true
  def render(assigns) do
    RootComponent.render(assigns)
  end

  @impl true
  def handle_params(%{"name" => name}, _uri, socket) do
    Game.add_player(name)
    {:noreply, assign(socket, name: name, map: get_game_state())}
  end

  def handle_params(_, _uri, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("set_name", %{"name" => name}, socket) do
    {:noreply,
     push_redirect(socket, to: Routes.live_path(socket, SwagSoulsWeb.PageLive, %{name: name}))
    }
  end

  def handle_event("perform_action", %{"key" => "ArrowUp"}, socket) do
    Game.move_player(Map.get(socket.assigns, :name), :up)

    {:noreply, socket}
  end

  def handle_event("perform_action", %{"key" => "ArrowDown"}, socket) do
    Game.move_player(Map.get(socket.assigns, :name), :down)

    {:noreply, socket}
  end

  def handle_event("perform_action", %{"key" => "ArrowLeft"}, socket) do
    Game.move_player(Map.get(socket.assigns, :name), :left)

    {:noreply, socket}
  end

  def handle_event("perform_action", %{"key" => "ArrowRight"}, socket) do
    Game.move_player(Map.get(socket.assigns, :name), :right)

    {:noreply, socket}
  end

  def handle_event("perform_action", %{"key" => "a"}, socket) do
    Game.perform_attack(Map.get(socket.assigns, :name))

    {:noreply, socket}
  end

  def handle_event("perform_action", _key, socket), do: {:noreply, socket}

  @impl true
  def handle_info(%{event: "update_map_state", payload: new_map_state}, socket) do
    name = Map.get(socket.assigns, :name)

    if name do
      {:noreply,
      push_redirect(assign(socket, map: new_map_state), to: Routes.live_path(socket, SwagSoulsWeb.PageLive, %{name: Map.get(socket.assigns, :name)}))}
    else
      {:noreply, assign(socket, map: new_map_state)}
    end
  end

  defp get_game_state() do
    Game.collect_current_state()
  end
end
