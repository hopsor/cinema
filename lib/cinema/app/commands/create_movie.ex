defmodule Cinema.App.Commands.CreateMovie do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__

  embedded_schema do
    field(:uuid, :string)
    field(:title, :string)
    field(:duration, :integer)
  end

  def new(attrs \\ %{}) do
    changeset =
      %CreateMovie{}
      |> cast(attrs, [:title, :duration])
      |> put_change(:uuid, Ecto.UUID.generate())
      |> validate_required([:title, :duration])

    if changeset.valid? do
      {:ok, apply_changes(changeset)}
    else
      {:error, :invalid_attributes, changeset}
    end
  end
end
