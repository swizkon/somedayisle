defmodule SomedayIsle.Repo.Migrations.CreateCompletionsView do
  use Ecto.Migration
 def up do
    execute """
    CREATE VIEW completions AS
      SELECT * FROM Users
    ;
    """
  end

  def down do
    execute "DROP VIEW completions;"
  end

end
