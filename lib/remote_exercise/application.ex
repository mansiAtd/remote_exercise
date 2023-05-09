defmodule RemoteExercise.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      RemoteExerciseWeb.Telemetry,
      # Start the Ecto repository
      RemoteExercise.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: RemoteExercise.PubSub},
      # Start Finch
      {Finch, name: RemoteExercise.Finch},
      # Start the Endpoint (http/https)
      RemoteExerciseWeb.Endpoint,
      # Genserver to update users table and retrive 2 users with max numbers.
      {RemoteExercise.RandomPointsGenerator, %{}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RemoteExercise.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RemoteExerciseWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
