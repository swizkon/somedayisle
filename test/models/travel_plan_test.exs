defmodule SomedayIsle.TravelPlanTest do
  use SomedayIsle.ModelCase

  alias SomedayIsle.TravelPlan

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TravelPlan.changeset(%TravelPlan{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TravelPlan.changeset(%TravelPlan{}, @invalid_attrs)
    refute changeset.valid?
  end
end
