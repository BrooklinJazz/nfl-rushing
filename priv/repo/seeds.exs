# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rush.Repo.insert!(%Rush.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
with {:ok, body} <- File.read("rushing.json"),
     {:ok, json} <- Jason.decode(body) do
  IO.inspect(json)

  Enum.each(json, fn each ->
    {total_rushing_yards, _} =
      if is_bitstring(each["Yds"]), do: Integer.parse(each["Yds"]), else: {each["Yds"], ""}

    longest_rush =
      if is_integer(each["Lng"]), do: Integer.to_string(each["Lng"]), else: each["Lng"]

    Rush.Repo.insert!(%Rush.Football.Record{
      rushing_attempts: each["Att"],
      avg_rushing_attempts_per_game: each["Att/G"] / 1,
      avg_rushing_yards_per_attempt: each["Avg"] / 1,
      longest_rush: longest_rush,
      player: each["Player"],
      position: each["Pos"],
      rushing_20_plus_yards_each: each["20+"],
      rushing_40_plus_yards_each: each["40+"],
      rushing_first_down_percentage: each["1st%"] / 1,
      rushing_first_downs: each["1st"],
      rushing_fumbles: each["FUM"],
      rushing_yards_per_game: each["Yds/G"] / 1,
      team: each["Team"],
      total_rushing_touchdowns: each["TD"],
      total_rushing_yards: total_rushing_yards
    })
  end)
end
