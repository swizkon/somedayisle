defmodule SomedayIsle.Repo.Migrations.CreateTravelPlan do
  use Ecto.Migration

  def change do
    create table(:travelplans) do
      add :name, :string

      timestamps()
    end

  end
end
