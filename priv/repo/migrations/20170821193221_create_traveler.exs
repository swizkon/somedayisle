defmodule SomedayIsle.Repo.Migrations.CreateTraveler do
  use Ecto.Migration

  def change do
    create table(:travelers) do
      add :name, :string
      add :completed_legs, :integer
      add :total_legs, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :journey_id, references(:journeys, on_delete: :nothing)

      timestamps()
    end

  end
end
