defmodule SomedayIsle.User do
  use SomedayIsle.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string

    has_many :travelers, SomedayIsle.Traveler

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email])
    |> validate_required([:name, :email])
  end
end
