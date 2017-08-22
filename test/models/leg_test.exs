defmodule SomedayIsle.LegTest do
  use SomedayIsle.ModelCase

  alias SomedayIsle.Leg

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Leg.changeset(%Leg{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Leg.changeset(%Leg{}, @invalid_attrs)
    refute changeset.valid?
  end
end
