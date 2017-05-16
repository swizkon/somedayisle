defmodule SomedayIsle.CircuitController do
  use SomedayIsle.Web, :controller

  alias SomedayIsle.Circuit

  def options(conn, _params) do
    conn
    #circuits = Repo.all(Circuit)
    #render(conn, "index.json", circuits: circuits)
  end

  def index(conn, _params) do
    circuits = Repo.all(Circuit)
    render(conn, "index.json", circuits: circuits)
  end

  def create(conn, %{"circuit" => circuit_params}) do
    changeset = Circuit.changeset(%Circuit{}, circuit_params)

    case Repo.insert(changeset) do
      {:ok, circuit} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", circuit_path(conn, :show, circuit))
        |> render("show.json", circuit: circuit)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SomedayIsle.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    circuit = Repo.get!(Circuit, id)
    render(conn, "show.json", circuit: circuit)
  end

  def update(conn, %{"id" => id, "circuit" => circuit_params}) do
    circuit = Repo.get!(Circuit, id)
    changeset = Circuit.changeset(circuit, circuit_params)

    case Repo.update(changeset) do
      {:ok, circuit} ->
        render(conn, "show.json", circuit: circuit)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SomedayIsle.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    circuit = Repo.get!(Circuit, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(circuit)

    send_resp(conn, :no_content, "")
  end
end
