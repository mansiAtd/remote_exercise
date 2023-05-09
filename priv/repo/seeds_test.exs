## Inserts 1,00 records into users table with 0 points for test database.
Enum.each(
  1..1_00,
  fn _ ->
    RemoteExercise.Repo.insert(%RemoteExercise.User{})
  end
)
