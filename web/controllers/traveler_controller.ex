defmodule SomedayIsle.TravelerController do
  use SomedayIsle.Web, :controller

  alias SomedayIsle.Traveler

  def index(conn, _params) do
    travelers = Repo.all(Traveler)
    render(conn, "index.html", travelers: travelers)
  end

  def new(conn, _params) do
    changeset = Traveler.changeset(%Traveler{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"traveler" => traveler_params}) do
    changeset = Traveler.changeset(%Traveler{}, traveler_params)

    case Repo.insert(changeset) do
      {:ok, _traveler} ->
        conn
        |> put_flash(:info, "Traveler created successfully.")
        |> redirect(to: traveler_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    traveler = Repo.get!(Traveler, id)
    render(conn, "show.html", traveler: traveler)
  end

  def edit(conn, %{"id" => id}) do
    traveler = Repo.get!(Traveler, id)
    changeset = Traveler.changeset(traveler)
    render(conn, "edit.html", traveler: traveler, changeset: changeset)
  end

  def update(conn, %{"id" => id, "traveler" => traveler_params}) do
    traveler = Repo.get!(Traveler, id)
    changeset = Traveler.changeset(traveler, traveler_params)

    case Repo.update(changeset) do
      {:ok, traveler} ->
        conn
        |> put_flash(:info, "Traveler updated successfully.")
        |> redirect(to: traveler_path(conn, :show, traveler))
      {:error, changeset} ->
        render(conn, "edit.html", traveler: traveler, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    traveler = Repo.get!(Traveler, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(traveler)

    conn
    |> put_flash(:info, "Traveler deleted successfully.")
    |> redirect(to: traveler_path(conn, :index))
  end
end
