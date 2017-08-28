defmodule SomedayIsle.Detour do
  use SomedayIsle.Web, :model

  schema "detours" do
    field :name, :string
    field :description, :string

    belongs_to :leg, SomedayIsle.Leg

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name, :description])
  end
end
