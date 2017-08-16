defmodule SomedayIsle.Repo.Migrations.CreateDetour do
  use Ecto.Migration

  def change do
    create table(:detours) do
      add :name, :string
      add :desc, :string
      add :pitstop_id, references(:pitstops, on_delete: :nothing)

      timestamps()
    end
    create index(:detours, [:pitstop_id])

  end
end
