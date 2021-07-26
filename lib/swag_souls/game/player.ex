defmodule SwagSouls.Game.Player do
  use GenServer

  alias SwagSouls.Players.Player
  alias SwagSouls.GameLogic.ProcessMovement
  alias SwagSouls.GameLogic.ProcessAttack
  alias SwagSouls.Game.MapServer

  @registry SwagSouls.Game.PlayerRegistry
  @player_server SwagSouls.Game.PlayerServer

  @spec start_link(Player.t()) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(player) do
    GenServer.start_link(__MODULE__, player, name: via_tuple(player.name))
  end

  @impl true
  @spec init(Player.t()) :: {:ok, Player.t()}
  def init(player) do
    {:ok, player}
  end

  @spec get_player(pid()) :: Player.t()
  def get_player(pid) do
    GenServer.call(pid, :get_player)
  end

  @spec perform_attack(pid()) :: :ok
  def perform_attack(pid) do
    GenServer.cast(pid, :perform_attack)
  end

  @spec attack_enemy(pid(), Player.t()) :: :ok
  def attack_enemy(pid, attacker) do
    GenServer.cast(pid, {:attack_enemy, attacker})
  end

  @spec move(pid(), atom()) :: :ok
  def move(pid, direction) do
    GenServer.cast(pid, {:move, direction})
  end

  @impl true
  def handle_call(:get_player, _from, player) do
    {:reply, player, player}
  end

  @impl true
  @spec handle_cast(:perform_attack, Player.t()) :: {:noreply, Player.t()}
  def handle_cast(:perform_attack, player) do
    do_perform_attack(player)
    {:noreply, player}
  end

  @spec handle_cast({:attack_enemy, Player.t()}, Player.t()) :: {:noreply, Player.t()}
  def handle_cast({:attack_enemy, attacker}, player) do
    new_player_state = ProcessAttack.call(attacker, player)

    case new_player_state.state do
      :alive -> {:noreply, new_player_state}
      :dead -> Process.send_after(self(), :resurrect, 5_000)
               {:noreply, new_player_state}
    end
  end

  @spec handle_cast({:move, atom()}, Player.t()) :: {:noreply, Player.t()}
  def handle_cast({:move, direction}, player) do
    new_player_state = ProcessMovement.call(MapServer.get_map(), player, direction)

    {:noreply, new_player_state}
  end

  @impl true
  def handle_info(:resurrect, player_state) do
    new_state = %Player{player_state | state: :alive, coordinates: MapServer.get_random_grass_tile()}

    {:noreply, new_state}
  end

  defp do_perform_attack(player) do
    DynamicSupervisor.which_children(@player_server)
    |> Enum.each(
      fn {_, pid, _type, _modules} ->
        if pid != self() do
          SwagSouls.Game.Player.attack_enemy(pid, player)
        end
      end
    )
  end

  defp via_tuple(player_name) do
    @registry.via_tuple(player_name)
  end
end
