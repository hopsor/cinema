defmodule Cinema.App.Router do
  use Commanded.Commands.Router

  alias Cinema.App.Aggregates.Movie
  alias Cinema.App.Commands.CreateMovie
  alias Cinema.App.Commands.UpdateMovie

  dispatch(CreateMovie, to: Movie, identity: :uuid)
  dispatch(UpdateMovie, to: Movie, identity: :uuid)
end
