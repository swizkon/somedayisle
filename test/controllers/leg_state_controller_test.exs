defmodule SomedayIsle.LegStateControllerTest do
  use SomedayIsle.ConnCase

  alias SomedayIsle.LegState
  @valid_attrs %{"": 42, status: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, leg_state_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing leg states"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, leg_state_path(conn, :new)
    assert html_response(conn, 200) =~ "New leg state"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, leg_state_path(conn, :create), leg_state: @valid_attrs
    assert redirected_to(conn) == leg_state_path(conn, :index)
    assert Repo.get_by(LegState, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, leg_state_path(conn, :create), leg_state: @invalid_attrs
    assert html_response(conn, 200) =~ "New leg state"
  end

  test "shows chosen resource", %{conn: conn} do
    leg_state = Repo.insert! %LegState{}
    conn = get conn, leg_state_path(conn, :show, leg_state)
    assert html_response(conn, 200) =~ "Show leg state"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, leg_state_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    leg_state = Repo.insert! %LegState{}
    conn = get conn, leg_state_path(conn, :edit, leg_state)
    assert html_response(conn, 200) =~ "Edit leg state"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    leg_state = Repo.insert! %LegState{}
    conn = put conn, leg_state_path(conn, :update, leg_state), leg_state: @valid_attrs
    assert redirected_to(conn) == leg_state_path(conn, :show, leg_state)
    assert Repo.get_by(LegState, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    leg_state = Repo.insert! %LegState{}
    conn = put conn, leg_state_path(conn, :update, leg_state), leg_state: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit leg state"
  end

  test "deletes chosen resource", %{conn: conn} do
    leg_state = Repo.insert! %LegState{}
    conn = delete conn, leg_state_path(conn, :delete, leg_state)
    assert redirected_to(conn) == leg_state_path(conn, :index)
    refute Repo.get(LegState, leg_state.id)
  end
end
