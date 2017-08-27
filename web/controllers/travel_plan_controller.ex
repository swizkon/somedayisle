defmodule SomedayIsle.TravelPlanController do
  use SomedayIsle.Web, :controller

  alias SomedayIsle.TravelPlan

  def index(conn, _params) do
    travelplans = Repo.all(TravelPlan)
    render(conn, "index.html", travelplans: travelplans)
  end

  def new(conn, _params) do
    changeset = TravelPlan.changeset(%TravelPlan{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"travel_plan" => travel_plan_params}) do
    changeset = TravelPlan.changeset(%TravelPlan{}, travel_plan_params)

    case Repo.insert(changeset) do
      {:ok, _travel_plan} ->
        conn
        |> put_flash(:info, "Travel plan created successfully.")
        |> redirect(to: travel_plan_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    travel_plan = Repo.get!(TravelPlan, id)
    render(conn, "show.html", travel_plan: travel_plan)
  end

  def edit(conn, %{"id" => id}) do
    travel_plan = Repo.get!(TravelPlan, id)
    changeset = TravelPlan.changeset(travel_plan)
    render(conn, "edit.html", travel_plan: travel_plan, changeset: changeset)
  end

  def update(conn, %{"id" => id, "travel_plan" => travel_plan_params}) do
    travel_plan = Repo.get!(TravelPlan, id)
    changeset = TravelPlan.changeset(travel_plan, travel_plan_params)

    case Repo.update(changeset) do
      {:ok, travel_plan} ->
        conn
        |> put_flash(:info, "Travel plan updated successfully.")
        |> redirect(to: travel_plan_path(conn, :show, travel_plan))
      {:error, changeset} ->
        render(conn, "edit.html", travel_plan: travel_plan, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    travel_plan = Repo.get!(TravelPlan, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(travel_plan)

    conn
    |> put_flash(:info, "Travel plan deleted successfully.")
    |> redirect(to: travel_plan_path(conn, :index))
  end
end
