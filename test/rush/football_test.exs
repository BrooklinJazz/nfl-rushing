defmodule Rush.FootballTest do
  use Rush.DataCase

  alias Rush.Football

  describe "records" do
    alias Rush.Football.Record

    import Rush.FootballFixtures

    @invalid_attrs %{
      avg_rushing_attempts_per_game: nil,
      avg_rushing_yards_per_attempt: nil,
      longest_rush: nil,
      player: nil,
      position: nil,
      rushing_20_plus_yards_each: nil,
      rushing_40_plus_yards_each: nil,
      rushing_first_down_percentage: nil,
      rushing_first_downs: nil,
      rushing_fumbles: nil,
      rushing_yards_per_game: nil,
      team: nil,
      total_rushing_touchdowns: nil,
      total_rushing_yards: nil
    }

    test "list_records/0 returns all records" do
      record = record_fixture()
      assert Football.list_records() == [record]
    end

    test "list_records/1 filter by player name" do
      record = record_fixture()

      assert Football.list_records(%{player: record.player}) == [record]
      assert Football.list_records(%{player: String.capitalize(record.player)}) == [record]
      assert Football.list_records(%{player: String.first(record.player)}) == [record]
      assert Football.list_records(%{player: String.last(record.player)}) == [record]

      assert Football.list_records(%{player: ""}) == [record]
      assert Football.list_records(%{player: nil}) == [record]
      assert Football.list_records(%{player: "invalid_name"}) == []
    end

    test "list_records/1 sort by total rushing yards" do
      # "_Total Rushing Yards_, _Longest Rush_ and _Total Rushing Touchdowns_"
      s = record_fixture(%{total_rushing_yards: 0})
      m = record_fixture(%{total_rushing_yards: 1})
      l = record_fixture(%{total_rushing_yards: 2})

      assert Football.list_records(%{sort_by: :total_rushing_yards}) == [s, m, l]

      assert Football.list_records(%{
               sort_by: :total_rushing_yards,
               order_by: :smallest
             }) == [s, m, l]

      assert Football.list_records(%{
               sort_by: :total_rushing_yards,
               order_by: :largest
             }) == [l, m, s]
    end

    test "list_records/1 sort by longest_rush" do
      s = record_fixture(%{longest_rush: "1T"})
      m = record_fixture(%{longest_rush: "2T"})
      l = record_fixture(%{longest_rush: "3"})

      assert Football.list_records(%{sort_by: :longest_rush}) == [s, m, l]

      assert Football.list_records(%{
               sort_by: :longest_rush,
               order_by: :smallest
             }) == [s, m, l]

      assert Football.list_records(%{
               sort_by: :longest_rush,
               order_by: :largest
             }) == [l, m, s]
    end

    test "list_records/1 sort by total_rushing_touchdowns" do
      s = record_fixture(%{total_rushing_touchdowns: 0})
      m = record_fixture(%{total_rushing_touchdowns: 1})
      l = record_fixture(%{total_rushing_touchdowns: 2})

      assert Football.list_records(%{sort_by: :total_rushing_touchdowns}) == [s, m, l]

      assert Football.list_records(%{
               sort_by: :total_rushing_touchdowns,
               order_by: :smallest
             }) == [s, m, l]

      assert Football.list_records(%{
               sort_by: :total_rushing_touchdowns,
               order_by: :largest
             }) == [l, m, s]
    end

    test "create_record/1 with valid data creates a record" do
      valid_attrs = %{
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
      }

      assert {:ok, %Record{} = record} = Football.create_record(valid_attrs)
      assert match?(valid_attrs, record)
    end

    test "create_record/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Football.create_record(@invalid_attrs)
    end

    test "generate_csv/1" do
      record = record_fixture()
      csv = Football.generate_csv([record])

      record
      |> Map.drop([:__meta__, :updated_at, :inserted_at, :__struct__, :id])
      |> Map.values()
      |> Enum.each(fn value ->
        assert csv =~ "#{value}"
      end)
    end
  end
end
