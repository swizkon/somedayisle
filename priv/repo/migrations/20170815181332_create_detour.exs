defmodule SomedayIsle.Repo.Migrations.CreateDetour do
  use Ecto.Migration

  def change do
    create table(:detours) do
      add :name, :string
      add :description, :string
      add :leg_id, references(:legs, on_delete: :nothing)

      timestamps()
    end
    create index(:detours, [:leg_id])

  end
end
