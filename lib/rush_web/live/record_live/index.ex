defmodule RushWeb.RecordLive.Index do
  use RushWeb, :live_view

  alias Rush.Football

  @impl true
  def mount(_params, _session, socket) do
    records = Football.list_records()

    {:ok,
     assign(socket,
       order_by: nil,
       sort_by: nil,
       player: "",
       records: records,
       csv: generate_csv(records)
     )}
  end

  defp generate_csv(records) do
    Football.generate_csv(records)
  end

  @impl true
  def handle_event("filter", %{"filter" => %{"player" => player}}, socket) do
    {:noreply, assign(socket, player: player) |> load_records()}
  end

  def handle_event("sort", %{"sort" => %{"sort_by" => sort_by, "order_by" => order_by}}, socket) do
    {:noreply, assign(socket, sort_by: sort_by, order_by: order_by) |> load_records()}
  end

  def load_records(socket) do
    %{sort_by: sort_by, order_by: order_by, player: player} = socket.assigns

    records =
      Football.list_records(%{
        sort_by: maybe_to_atom(sort_by),
        order_by: maybe_to_atom(order_by),
        player: player
      })

    assign(socket, records: records, csv: generate_csv(records))
  end

  defp maybe_to_atom(value) do
    unless value == "" || !value do
      String.to_existing_atom(value)
    end
  end
end
