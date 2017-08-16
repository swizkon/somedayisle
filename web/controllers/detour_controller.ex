defmodule SomedayIsle.DetourController do
  use SomedayIsle.Web, :controller

  alias SomedayIsle.Detour

  def index(conn, _params) do
    detours = Repo.all(Detour)
    render(conn, "index.json", detours: detours)
  end

  def create(conn, %{"detour" => detour_params}) do
    changeset = Detour.changeset(%Detour{}, detour_params)

    case Repo.insert(changeset) do
      {:ok, detour} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", detour_path(conn, :show, detour))
        |> render("show.json", detour: detour)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SomedayIsle.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    detour = Repo.get!(Detour, id)
    render(conn, "show.json", detour: detour)
  end

  def update(conn, %{"id" => id, "detour" => detour_params}) do
    detour = Repo.get!(Detour, id)
    changeset = Detour.changeset(detour, detour_params)

    case Repo.update(changeset) do
      {:ok, detour} ->
        render(conn, "show.json", detour: detour)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SomedayIsle.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    detour = Repo.get!(Detour, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(detour)

    send_resp(conn, :no_content, "")
  end
end
