defmodule Multiplex.App.Supervisor do
  @moduledoc false
  use Supervisor

  alias Multiplex.App

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
