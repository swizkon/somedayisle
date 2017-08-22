defmodule SomedayIsle.LegStateController do
  use SomedayIsle.Web, :controller

  alias SomedayIsle.LegState

  def index(conn, _params) do
    leg_states = Repo.all(LegState)
    render(conn, "index.html", leg_states: leg_states)
  end

  def new(conn, _params) do
    changeset = LegState.changeset(%LegState{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"leg_state" => leg_state_params}) do
    changeset = LegState.changeset(%LegState{}, leg_state_params)

    case Repo.insert(changeset) do
      {:ok, _leg_state} ->
        conn
        |> put_flash(:info, "Leg state created successfully.")
        |> redirect(to: leg_state_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    leg_state = Repo.get!(LegState, id)
    render(conn, "show.html", leg_state: leg_state)
  end

  def edit(conn, %{"id" => id}) do
    leg_state = Repo.get!(LegState, id)
    changeset = LegState.changeset(leg_state)
    render(conn, "edit.html", leg_state: leg_state, changeset: changeset)
  end

  def update(conn, %{"id" => id, "leg_state" => leg_state_params}) do
    leg_state = Repo.get!(LegState, id)
    changeset = LegState.changeset(leg_state, leg_state_params)

    case Repo.update(changeset) do
      {:ok, leg_state} ->
        conn
        |> put_flash(:info, "Leg state updated successfully.")
        |> redirect(to: leg_state_path(conn, :show, leg_state))
      {:error, changeset} ->
        render(conn, "edit.html", leg_state: leg_state, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    leg_state = Repo.get!(LegState, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(leg_state)

    conn
    |> put_flash(:info, "Leg state deleted successfully.")
    |> redirect(to: leg_state_path(conn, :index))
  end
end
