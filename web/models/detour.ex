defmodule SomedayIsle.Detour do
  use SomedayIsle.Web, :model

  schema "detours" do
    field :name, :string
    field :desc, :string

    belongs_to :pitstop, SomedayIsle.Pitstop

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :desc])
    |> validate_required([:name, :desc])
  end
end
