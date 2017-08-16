defmodule SomedayIsle.Repo.Migrations.AddOrdinalColToPitstops do
  use Ecto.Migration

  def change do
    alter table(:pitstops) do
      add :ordinal,    :integer
    end
  end
end
