defmodule RemoteExerciseWeb.UserController do
  use RemoteExerciseWeb, :controller

  def index(conn, _params) do
    data = RemoteExercise.RandomPointsGenerator.get_users_with_points()

    render(conn, :index, data: data)
  end
end
