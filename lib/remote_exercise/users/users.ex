defmodule RemoteExercise.Users do
  alias RemoteExercise.{User, Repo}
  import Ecto.Query

  @doc """
  function to fetch max 2 users which have points greater than the max number .
  """
  def get_users_with_max_points(min_number) do
    from(u in User,
      where: u.points > ^min_number,
      select: %{
        id: u.id,
        points: u.points
      },
      limit: 2
    )
    |> Repo.all()
  end

  @doc """
  function to update points for all the users stored in the table.
  """
  def update_points_for_all_users() do
    query =
      from(
        u in User,
        update: [set: [points: fragment("floor(random()*100)")]]
      )

    Repo.update_all(query, [])
  end
end
