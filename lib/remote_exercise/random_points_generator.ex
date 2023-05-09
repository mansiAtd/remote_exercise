defmodule RemoteExercise.RandomPointsGenerator do
  use GenServer

  def start_link(args) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  ### Client API call

  @doc """
  function to fetch max 2 users which have points greater than the min number .
  """
  def get_users_with_points() do
    # timeout is set to 10 sec
    GenServer.call(RemoteExercise.RandomPointsGenerator, {:get_users_with_points}, 10_000)
  end

  ### Server Callbacks
  @impl true
  def init(_) do
    Process.send_after(self(), :update, 1000)
    {:ok, intial_state()}
  end

  @impl true
  def handle_info(:update, state) do
    RemoteExercise.Users.update_points_for_all_users()
    Process.send_after(self(), :update, 60 * 1000)
    {:noreply, state |> Map.put(:min_number, Enum.random(0..100))}
  end

  @impl true
  def handle_call({:get_users_with_points}, _from, state) do
    max_users = state |> Map.get(:min_number) |> RemoteExercise.Users.get_users_with_max_points()

    data = %{
      users: max_users,
      timestamp: DateTime.utc_now()
    }

    {:reply, data, state |> Map.put(:timestamp, DateTime.utc_now())}
  end

  defp intial_state() do
    min_num = Enum.random(0..100)
    %{min_number: min_num, timestamp: nil}
  end
end
