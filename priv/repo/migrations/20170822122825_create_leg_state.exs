defmodule SomedayIsle.Repo.Migrations.CreateLegState do
  use Ecto.Migration

  def change do
    create table(:leg_states) do
      add :status, :string
      add :leg_id, references(:legs, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:leg_states, [:user_id, :leg_id])

  end
end
