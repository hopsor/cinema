defmodule Cinema.App.Aggregates.Movie do
  @moduledoc false
  alias Cinema.App.Aggregates.Movie
  alias Cinema.App.Commands.CreateMovie
  alias Cinema.App.Commands.UpdateMovie
  alias Cinema.App.Events.MovieCreated
  alias Cinema.App.Events.MovieDurationUpdated
  alias Cinema.App.Events.MovieTitleUpdated

  defstruct [:uuid, :title, :duration]

  def execute(%Movie{uuid: nil}, %CreateMovie{} = create) do
    %MovieCreated{
      uuid: create.uuid,
      title: create.title,
      duration: create.duration
    }
  end

  def execute(%Movie{uuid: uuid} = movie, %UpdateMovie{} = update) do
    title_update_event =
      if movie.title != update.title do
        %MovieTitleUpdated{uuid: uuid, title: update.title}
      end

    duration_update_event =
      if movie.duration != update.duration do
        %MovieDurationUpdated{uuid: uuid, duration: update.duration}
      end

    Enum.filter([title_update_event, duration_update_event], &Function.identity/1)
  end

  def apply(%Movie{} = movie, %MovieCreated{} = created) do
    %{
      movie
      | uuid: created.uuid,
        title: created.title,
        duration: created.duration
    }
  end

  def apply(%Movie{} = movie, %MovieTitleUpdated{title: new_title}) do
    %{movie | title: new_title}
  end

  def apply(%Movie{} = movie, %MovieDurationUpdated{duration: new_duration}) do
    %{movie | duration: new_duration}
  end
end
