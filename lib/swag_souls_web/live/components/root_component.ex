defmodule RootComponent do
  use Surface.Component

  def render(assigns) do
    ~F"""
    {#if Map.get(assigns, :name) != nil}
      <GameWindowComponent
        map={Map.get(assigns, :map)}
        max_height={Map.get(assigns, :max_height)}
        max_width={Map.get(assigns, :max_width)}
        name={Map.get(assigns, :name)}/>
    {#else}
      <section class="phx-hero">
        <h1>Welcome to the club!</h1>
        <form phx-submit="set_name">
          <input type="text" name="name" placeholder="Enter your name"/>
          <button type="submit" phx-disable-with="Starting...">Start</button>
        </form>
      </section>
    {/if}
    """
  end
end
