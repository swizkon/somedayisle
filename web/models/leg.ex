defmodule SomedayIsle.Leg do
  use SomedayIsle.Web, :model

  schema "legs" do
    field :name, :string
    field :description, :string
    field :ordinal, :integer
    belongs_to :journey, SomedayIsle.Journey

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
