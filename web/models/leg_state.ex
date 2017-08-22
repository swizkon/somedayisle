defmodule SomedayIsle.LegState do
  use SomedayIsle.Web, :model

  schema "leg_states" do
    field :status, :string
    belongs_to :user, SomedayIsle.User
    belongs_to :leg, SomedayIsle.Leg

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:"", :status])
    |> validate_required([:"", :status])
  end
end
