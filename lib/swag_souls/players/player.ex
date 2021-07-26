defmodule SwagSouls.Players.Player do
  @type t :: %__MODULE__{
    name:        String.t,
    state:       Atom.t,
    coordinates: tuple()
  }

  defstruct [:name, :state, :coordinates]
end
