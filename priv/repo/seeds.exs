## Inserts 1,000,000 records into users table with 0 points .
Enum.each(
  1..1_000_000,
  fn _ ->
    RemoteExercise.Repo.insert(%RemoteExercise.User{})
  end
)
