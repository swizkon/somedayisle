defmodule SomedayIsle.Repo.Migrations.CreateCompletionsView do
  use Ecto.Migration
 def up do
    execute """
    CREATE VIEW completions AS
      SELECT u.* FROM Users as u
        JOIN leg_states as ls ON ls.user_id = u.id
        JOIN legs as l ON l.id = ls.leg_id
    ;
    """
  end

  def down do
    execute "DROP VIEW completions;"
  end

end
