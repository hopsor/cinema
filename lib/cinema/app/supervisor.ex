defmodule Cinema.App.Supervisor do
  use Supervisor

  alias Cinema.App

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      App.Application,
      App.Projectors.Movie
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
