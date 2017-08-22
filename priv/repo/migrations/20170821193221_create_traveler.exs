defmodule SomedayIsle.Repo.Migrations.CreateTraveler do
  use Ecto.Migration

  def change do
    create table(:travelers) do
      add :name, :string
      #add :user_id, :integer
      add :user_id, references(:journeys, on_delete: :nothing)
      add :journey_id, references(:journeys, on_delete: :nothing)

      timestamps()
    end

  end
end
