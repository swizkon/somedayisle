defmodule SomedayIsle.Repo.Migrations.CreateLeg do
  use Ecto.Migration

  def change do
    create table(:legs) do
      add :name, :string
      add :description, :string

      add :ordinal, :integer

      add :journey_id, references(:journeys, on_delete: :nothing)

      timestamps()
    end
    create index(:legs, [:journey_id])

  end
end
