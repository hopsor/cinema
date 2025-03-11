defmodule Cinema.App.Commands.UpdateMovie do
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
      %UpdateMovie{}
      |> cast(attrs, [:uuid, :title, :duration])
      |> validate_required([:uuid, :title, :duration])

    if changeset.valid? do
      {:ok, apply_changes(changeset)}
    else
      {:error, :invalid_attributes, changeset}
    end
  end
end
