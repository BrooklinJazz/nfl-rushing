defmodule RushWeb.RecordLive.Index do
  use RushWeb, :live_view

  alias Rush.Football

  @impl true
  def mount(_params, _session, socket) do
    records = list_records()
    {:ok, assign(socket, records: list_records(), csv: generate_csv(records))}
  end

  defp list_records do
    Football.list_records()
  end

  defp generate_csv(records) do
    Football.generate_csv(records)
  end
end
