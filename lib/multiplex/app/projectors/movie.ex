defmodule Multiplex.App.Projectors.Movie do
  @moduledoc false
  use Commanded.Projections.Ecto,
    application: Multiplex.App.Application,
    repo: Multiplex.Repo,
    name: __MODULE__,
    consistency: :strong

  alias Multiplex.App.Events.MovieCreated
  alias Multiplex.App.Events.MovieDurationUpdated
  alias Multiplex.App.Events.MovieTitleUpdated
  alias Multiplex.App.Projections.Movie
  alias Multiplex.Repo

  project(%MovieCreated{} = event, _metadata, fn multi ->
    movie = %Movie{uuid: event.uuid, title: event.title, duration: event.duration}
    Ecto.Multi.insert(multi, :movie, movie)
  end)

  project(%MovieTitleUpdated{uuid: uuid, title: new_title}, _metadata, fn multi ->
    case Repo.get(Movie, uuid) do
      nil -> multi
      movie -> Ecto.Multi.update(multi, :movie, Movie.changeset(movie, %{title: new_title}))
    end
  end)

  project(%MovieDurationUpdated{uuid: uuid, duration: new_duration}, _metadata, fn multi ->
    case Repo.get(Movie, uuid) do
      nil -> multi
      movie -> Ecto.Multi.update(multi, :movie, Movie.changeset(movie, %{duration: new_duration}))
    end
  end)
end
