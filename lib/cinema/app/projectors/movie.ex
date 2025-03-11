defmodule Cinema.App.Projectors.Movie do
  @moduledoc false
  use Commanded.Projections.Ecto,
    application: Cinema.App.Application,
    repo: Cinema.Repo,
    name: __MODULE__,
    consistency: :strong

  alias Cinema.App.Events.MovieCreated
  alias Cinema.App.Events.MovieDurationUpdated
  alias Cinema.App.Events.MovieTitleUpdated
  alias Cinema.App.Projections.Movie
  alias Cinema.Repo

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
