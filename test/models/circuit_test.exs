defmodule SomedayIsle.CircuitTest do
  use SomedayIsle.ModelCase

  alias SomedayIsle.Circuit

  @valid_attrs %{checkpoints: "some content", height: 42, name: "some content", scale: 42, width: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Circuit.changeset(%Circuit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Circuit.changeset(%Circuit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
