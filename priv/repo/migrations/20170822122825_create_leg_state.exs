defmodule SomedayIsle.Repo.Migrations.CreateLegState do
  use Ecto.Migration

  def change do
    create table(:leg_states) do
      add :"", :integer
      add :status, :string
      add :user, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:leg_states, [:user])

  end
end
