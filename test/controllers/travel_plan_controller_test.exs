defmodule SomedayIsle.TravelPlanControllerTest do
  use SomedayIsle.ConnCase

  alias SomedayIsle.TravelPlan
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, travel_plan_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing travelplans"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, travel_plan_path(conn, :new)
    assert html_response(conn, 200) =~ "New travel plan"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, travel_plan_path(conn, :create), travel_plan: @valid_attrs
    assert redirected_to(conn) == travel_plan_path(conn, :index)
    assert Repo.get_by(TravelPlan, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, travel_plan_path(conn, :create), travel_plan: @invalid_attrs
    assert html_response(conn, 200) =~ "New travel plan"
  end

  test "shows chosen resource", %{conn: conn} do
    travel_plan = Repo.insert! %TravelPlan{}
    conn = get conn, travel_plan_path(conn, :show, travel_plan)
    assert html_response(conn, 200) =~ "Show travel plan"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, travel_plan_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    travel_plan = Repo.insert! %TravelPlan{}
    conn = get conn, travel_plan_path(conn, :edit, travel_plan)
    assert html_response(conn, 200) =~ "Edit travel plan"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    travel_plan = Repo.insert! %TravelPlan{}
    conn = put conn, travel_plan_path(conn, :update, travel_plan), travel_plan: @valid_attrs
    assert redirected_to(conn) == travel_plan_path(conn, :show, travel_plan)
    assert Repo.get_by(TravelPlan, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    travel_plan = Repo.insert! %TravelPlan{}
    conn = put conn, travel_plan_path(conn, :update, travel_plan), travel_plan: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit travel plan"
  end

  test "deletes chosen resource", %{conn: conn} do
    travel_plan = Repo.insert! %TravelPlan{}
    conn = delete conn, travel_plan_path(conn, :delete, travel_plan)
    assert redirected_to(conn) == travel_plan_path(conn, :index)
    refute Repo.get(TravelPlan, travel_plan.id)
  end
end
