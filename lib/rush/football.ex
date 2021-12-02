defmodule Rush.Football do
  @moduledoc """
  The Football context.
  """
  alias CSV
  import Ecto.Query, warn: false
  alias Rush.Repo

  alias Rush.Football.Record

  @doc """
  Creates a record.

  ## Examples

      iex> create_record(%{field: value})
      {:ok, %Record{}}

      iex> create_record(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_record(attrs \\ %{}) do
    %Record{}
    |> Record.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the list of records.

  ## Examples

      iex> list_records()
      [%Record{}, ...]

  """

  def list_records(opts \\ %{}) do
    opts = Map.merge(%{player: nil, sort_by: nil, order_by: nil}, opts)

    from(Record)
    |> filter(opts.player)
    |> sort_by(opts.sort_by)
    |> order(opts.order_by)
    |> Repo.all()
  end

  def sort_by(query, field) do
    if field do
      order_by(query, [record], field(record, ^field))
    else
      query
    end
  end

  defp order(query, nil), do: query
  defp order(query, :smallest), do: query
  defp order(query, :largest), do: reverse_order(query)

  defp filter(query, player) do
    case player do
      "" ->
        query

      nil ->
        query

      player ->
        search_filter = "%#{player}%"
        where(query, [record], ilike(record.player, ^search_filter))
    end
  end

  def generate_csv(records) do
    csv_rows =
      Enum.map(records, fn each ->
        "#{each.player}," <>
          "#{each.team}," <>
          "#{each.position}," <>
          "#{each.rushing_attempts}," <>
          "#{each.avg_rushing_attempts_per_game}," <>
          "#{each.total_rushing_yards}," <>
          "#{each.avg_rushing_yards_per_attempt}," <>
          "#{each.rushing_yards_per_game}," <>
          "#{each.total_rushing_touchdowns}," <>
          "#{each.longest_rush}#{if each.longest_rush_resulted_in_touchdown, do: "T", else: ""}," <>
          "#{each.rushing_first_downs}," <>
          "#{each.rushing_first_down_percentage}," <>
          "#{each.rushing_20_plus_yards_each}," <>
          "#{each.rushing_40_plus_yards_each}," <>
          "#{each.rushing_fumbles},"
      end)
      |> Enum.join("\n")

    "Player,Team,Pos,Att,Att/G,Yds,Avg,Yds/G,TD,Lng,1st,1st%,20+,40+,FUM,\n" <> csv_rows
  end
end
