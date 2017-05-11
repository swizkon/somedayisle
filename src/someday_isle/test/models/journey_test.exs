defmodule SomedayIsle.JourneyTest do
  use SomedayIsle.ModelCase

  alias SomedayIsle.Journey

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Journey.changeset(%Journey{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Journey.changeset(%Journey{}, @invalid_attrs)
    refute changeset.valid?
  end
end
