defmodule SomedayIsle.TravelerTest do
  use SomedayIsle.ModelCase

  alias SomedayIsle.Traveler

  @valid_attrs %{journey_id: 42, name: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Traveler.changeset(%Traveler{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Traveler.changeset(%Traveler{}, @invalid_attrs)
    refute changeset.valid?
  end
end
