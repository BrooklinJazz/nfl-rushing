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

  def handle_event("sort", params, socket) do
    records =
      Football.list_records(%{
        sort_by: sort_value(params["sort"]["sort_by"]),
        order_by: sort_value(params["sort"]["order_by"])
      })

    {:noreply, assign(socket, records: records, csv: generate_csv(records))}
  end

  defp sort_value(value) do
    unless value == "" do
      String.to_existing_atom(value)
    end
  end
end
