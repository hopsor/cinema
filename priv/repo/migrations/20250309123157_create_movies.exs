defmodule Cinema.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :title, :string
      add :duration, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
