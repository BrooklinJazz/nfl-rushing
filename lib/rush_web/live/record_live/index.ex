defmodule RushWeb.RecordLive.Index do
  use RushWeb, :live_view

  alias Rush.Football

  @impl true
  def mount(_params, _session, socket) do
    records = Football.list_records()
    {:ok, assign(socket, records: records, csv: generate_csv(records))}
  end

  defp generate_csv(records) do
    Football.generate_csv(records)
  end

  @impl true
  def handle_event("filter", params, socket) do
    records = Football.list_records(%{player: params["filter"]["player"]})
    {:noreply, assign(socket, records: records, csv: generate_csv(records))}
  end
end
