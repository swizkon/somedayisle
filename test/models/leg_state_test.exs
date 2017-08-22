defmodule SomedayIsle.LegStateTest do
  use SomedayIsle.ModelCase

  alias SomedayIsle.LegState

  @valid_attrs %{"": 42, status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LegState.changeset(%LegState{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LegState.changeset(%LegState{}, @invalid_attrs)
    refute changeset.valid?
  end
end
