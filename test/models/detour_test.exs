defmodule SomedayIsle.DetourTest do
  use SomedayIsle.ModelCase

  alias SomedayIsle.Detour

  @valid_attrs %{desc: "some content", name: "some content", stop: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Detour.changeset(%Detour{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Detour.changeset(%Detour{}, @invalid_attrs)
    refute changeset.valid?
  end
end
