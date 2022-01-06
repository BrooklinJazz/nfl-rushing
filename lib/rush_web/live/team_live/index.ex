defmodule RushWeb.TeamLive.Index do
  use RushWeb, :live_view

  alias Rush.Football

  @impl true
  def mount(_params, _session, socket) do
    teams = Football.team_records()

    {:ok, assign(socket, teams: teams)}
  end
end
