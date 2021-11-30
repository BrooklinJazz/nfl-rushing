defmodule RushWeb.RecordLive.Index do
  use RushWeb, :live_view

  alias Rush.Football

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :records, list_records())}
  end

  defp list_records do
    Football.list_records()
  end
end
