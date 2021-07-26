# SwagSouls

Dependencies:

  * Elixir -> 1.12.2-otp-24
  * Erlang -> 24.0.3

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Controls:

  * Arrow keys to move
  * `a` to attack

Game rules:

  * Players can only move on grass tiles
  * Players can overlap one another
  * A player can kill everybody around him/her or on the same tile by pressing the attack button
  * Dead players resurrect in 5 seconds
  * Dead players cannot perform any action

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
