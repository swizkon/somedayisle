defmodule SomedayIsle.EnduranceController do
  use SomedayIsle.Web, :controller

  alias SomedayIsle.Circuit

  def index(conn, _params) do
    circuits = Repo.all(Circuit)
    render(conn, "index.html", circuits: circuits)
  end

  def show(conn, %{"circuitid" => circuitid}) do
    circuit = Repo.get!(Circuit, circuitid)
    render(conn, "show.html", circuit: circuit)
  end
  
end
