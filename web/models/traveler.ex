defmodule SomedayIsle.Traveler do
  use SomedayIsle.Web, :model

  schema "travelers" do
    field :name, :string

    belongs_to :user, SomedayIsle.User
    belongs_to :journey, SomedayIsle.Journey

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :user_id, :journey_id])
    |> validate_required([:name, :user_id, :journey_id])
  end
end
