defmodule RemoteExerciseWeb.UserControllerTest do
  use RemoteExerciseWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert json_response(conn, 200)
  end
end
