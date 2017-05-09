defmodule SomedayIsle.PageController do
  use SomedayIsle.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
