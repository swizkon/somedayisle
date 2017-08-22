defmodule SomedayIsle.TravelerControllerTest do
  use SomedayIsle.ConnCase

  alias SomedayIsle.Traveler
  @valid_attrs %{journey_id: 42, name: "some content", user_id: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, traveler_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing travelers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, traveler_path(conn, :new)
    assert html_response(conn, 200) =~ "New traveler"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, traveler_path(conn, :create), traveler: @valid_attrs
    assert redirected_to(conn) == traveler_path(conn, :index)
    assert Repo.get_by(Traveler, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, traveler_path(conn, :create), traveler: @invalid_attrs
    assert html_response(conn, 200) =~ "New traveler"
  end

  test "shows chosen resource", %{conn: conn} do
    traveler = Repo.insert! %Traveler{}
    conn = get conn, traveler_path(conn, :show, traveler)
    assert html_response(conn, 200) =~ "Show traveler"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, traveler_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    traveler = Repo.insert! %Traveler{}
    conn = get conn, traveler_path(conn, :edit, traveler)
    assert html_response(conn, 200) =~ "Edit traveler"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    traveler = Repo.insert! %Traveler{}
    conn = put conn, traveler_path(conn, :update, traveler), traveler: @valid_attrs
    assert redirected_to(conn) == traveler_path(conn, :show, traveler)
    assert Repo.get_by(Traveler, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    traveler = Repo.insert! %Traveler{}
    conn = put conn, traveler_path(conn, :update, traveler), traveler: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit traveler"
  end

  test "deletes chosen resource", %{conn: conn} do
    traveler = Repo.insert! %Traveler{}
    conn = delete conn, traveler_path(conn, :delete, traveler)
    assert redirected_to(conn) == traveler_path(conn, :index)
    refute Repo.get(Traveler, traveler.id)
  end
end
