defmodule SomedayIsle.LegControllerTest do
  use SomedayIsle.ConnCase

  alias SomedayIsle.Leg
  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, leg_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing legs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, leg_path(conn, :new)
    assert html_response(conn, 200) =~ "New leg"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, leg_path(conn, :create), leg: @valid_attrs
    assert redirected_to(conn) == leg_path(conn, :index)
    assert Repo.get_by(Leg, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, leg_path(conn, :create), leg: @invalid_attrs
    assert html_response(conn, 200) =~ "New leg"
  end

  test "shows chosen resource", %{conn: conn} do
    leg = Repo.insert! %Leg{}
    conn = get conn, leg_path(conn, :show, leg)
    assert html_response(conn, 200) =~ "Show leg"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, leg_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    leg = Repo.insert! %Leg{}
    conn = get conn, leg_path(conn, :edit, leg)
    assert html_response(conn, 200) =~ "Edit leg"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    leg = Repo.insert! %Leg{}
    conn = put conn, leg_path(conn, :update, leg), leg: @valid_attrs
    assert redirected_to(conn) == leg_path(conn, :show, leg)
    assert Repo.get_by(Leg, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    leg = Repo.insert! %Leg{}
    conn = put conn, leg_path(conn, :update, leg), leg: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit leg"
  end

  test "deletes chosen resource", %{conn: conn} do
    leg = Repo.insert! %Leg{}
    conn = delete conn, leg_path(conn, :delete, leg)
    assert redirected_to(conn) == leg_path(conn, :index)
    refute Repo.get(Leg, leg.id)
  end
end
