defmodule SomedayIsle.LegController do
  use SomedayIsle.Web, :controller

  alias SomedayIsle.Leg

  def index(conn, _params) do
    legs = Repo.all(Leg)
    render(conn, "index.html", legs: legs)
  end

  def new(conn, _params) do
    changeset = Leg.changeset(%Leg{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"leg" => leg_params}) do
    changeset = Leg.changeset(%Leg{}, leg_params)

    case Repo.insert(changeset) do
      {:ok, _leg} ->
        conn
        |> put_flash(:info, "Leg created successfully.")
        |> redirect(to: leg_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    leg = Repo.get!(Leg, id)
    |> Repo.preload([:journey])
    render(conn, "show.html", leg: leg)
  end

  def edit(conn, %{"id" => id}) do
    leg = Repo.get!(Leg, id)
    changeset = Leg.changeset(leg)
    render(conn, "edit.html", leg: leg, changeset: changeset)
  end

  def update(conn, %{"id" => id, "leg" => leg_params}) do
    leg = Repo.get!(Leg, id)
    changeset = Leg.changeset(leg, leg_params)

    case Repo.update(changeset) do
      {:ok, leg} ->
        conn
        |> put_flash(:info, "Leg updated successfully.")
        |> redirect(to: leg_path(conn, :show, leg))
      {:error, changeset} ->
        render(conn, "edit.html", leg: leg, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    leg = Repo.get!(Leg, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(leg)

    conn
    |> put_flash(:info, "Leg deleted successfully.")
    |> redirect(to: leg_path(conn, :index))
  end
end
