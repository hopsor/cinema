defmodule Cinema.App.Projections.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :uuid}

  schema "movies" do
    field :title, :string
    field :duration, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :duration])
    |> validate_required([:title, :duration])
  end
end
