defmodule RemoteExercise.RandomPointsGeneratorTest do
  use ExUnit.Case, async: true

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(RemoteExercise.Repo)
    # Setting the shared mode must be done only after checkout
    Ecto.Adapters.SQL.Sandbox.mode(RemoteExercise.Repo, {:shared, self()})
  end

  describe "init function" do
    test "inital state of gen server" do
      assert !is_nil(RemoteExercise.RandomPointsGenerator.init(%{}))
    end
  end

  describe "updating user points using handle_info callback" do
    test "handle_info callback" do
      state = %{min_number: 21, timestamp: nil}
      data = RemoteExercise.RandomPointsGenerator.handle_info(:update, state)
      assert elem(data, 0) == :noreply
    end
  end

  describe "getting user points using handle_call callback" do
    test "handle_call callback" do
      state = %{min_number: 21, timestamp: nil}

      data =
        RemoteExercise.RandomPointsGenerator.handle_call({:get_users_with_points}, nil, state)

      assert elem(data, 0) == :reply
    end
  end

  describe "Testing of functions interacting with db" do
    test "get users with max points" do
      min_number = Enum.random(1..100)

      # function will return an empty list as the db restarts with each test
      # and there is no update happened till now, thus user points are still zero.
      assert Enum.empty?(RemoteExercise.Users.get_users_with_max_points(min_number))
    end

    test "update users points" do
      # updates all the 100 rows in users table with a random number
      assert {100, _} = RemoteExercise.Users.update_points_for_all_users()
    end
  end
end
