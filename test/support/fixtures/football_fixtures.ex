defmodule Rush.FootballFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rush.Football` context.
  """

  @doc """
  Generate a record.
  """
  def record_fixture(attrs \\ %{}) do
    {:ok, record} =
      attrs
      |> Enum.into(%{
        rushing_attempts: 456,
        avg_rushing_attempts_per_game: 120.5,
        avg_rushing_yards_per_attempt: 120.5,
        longest_rush: "some longest_rush",
        player: "some player",
        position: "some position",
        rushing_20_plus_yards_each: 42,
        rushing_40_plus_yards_each: 42,
        rushing_first_down_percentage: 120.5,
        rushing_first_downs: 42,
        rushing_fumbles: 42,
        rushing_yards_per_game: 120.5,
        team: "some team",
        total_rushing_touchdowns: 42,
        total_rushing_yards: 42
      })
      |> Rush.Football.create_record()

    record
  end
end
