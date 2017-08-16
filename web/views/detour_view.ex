defmodule SomedayIsle.DetourView do
  use SomedayIsle.Web, :view

  def render("index.json", %{detours: detours}) do
    %{data: render_many(detours, SomedayIsle.DetourView, "detour.json")}
  end

  def render("show.json", %{detour: detour}) do
    %{data: render_one(detour, SomedayIsle.DetourView, "detour.json")}
  end

  def render("detour.json", %{detour: detour}) do
    %{id: detour.id,
      name: detour.name,
      #pitstop: detour.pitstop,
      desc: detour.desc}
  end
end
