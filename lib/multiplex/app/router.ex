defmodule Multiplex.App.Router do
  use Commanded.Commands.Router

  alias Multiplex.App.Aggregates.Movie
  alias Multiplex.App.Commands.CreateMovie
  alias Multiplex.App.Commands.UpdateMovie

  dispatch(CreateMovie, to: Movie, identity: :uuid)
  dispatch(UpdateMovie, to: Movie, identity: :uuid)
end
