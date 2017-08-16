defmodule SomedayIsle.DetourControllerTest do
  use SomedayIsle.ConnCase

  alias SomedayIsle.Detour
  @valid_attrs %{desc: "some content", name: "some content", stop: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, detour_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    detour = Repo.insert! %Detour{}
    conn = get conn, detour_path(conn, :show, detour)
    assert json_response(conn, 200)["data"] == %{"id" => detour.id,
      "name" => detour.name,
      "stop" => detour.stop,
      "desc" => detour.desc}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, detour_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, detour_path(conn, :create), detour: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Detour, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, detour_path(conn, :create), detour: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    detour = Repo.insert! %Detour{}
    conn = put conn, detour_path(conn, :update, detour), detour: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Detour, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    detour = Repo.insert! %Detour{}
    conn = put conn, detour_path(conn, :update, detour), detour: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    detour = Repo.insert! %Detour{}
    conn = delete conn, detour_path(conn, :delete, detour)
    assert response(conn, 204)
    refute Repo.get(Detour, detour.id)
  end
end
