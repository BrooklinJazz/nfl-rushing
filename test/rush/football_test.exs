defmodule Rush.FootballTest do
  use Rush.DataCase

  alias Rush.Football

  describe "records" do
    alias Rush.Football.Record

    import Rush.FootballFixtures

    @invalid_attrs %{avg_rushing_attempts_per_game: nil, avg_rushing_yards_per_attempt: nil, longest_rush: nil, player: nil, position: nil, rushing_20_plus_yards_each: nil, rushing_40_plus_yards_each: nil, rushing_first_down_percentage: nil, rushing_first_downs: nil, rushing_fumbles: nil, rushing_yards_per_game: nil, team: nil, total_rushing_touchdowns: nil, total_rushing_yards: nil}

    test "list_records/0 returns all records" do
      record = record_fixture()
      assert Football.list_records() == [record]
    end

    test "get_record!/1 returns the record with given id" do
      record = record_fixture()
      assert Football.get_record!(record.id) == record
    end

    test "create_record/1 with valid data creates a record" do
      valid_attrs = %{avg_rushing_attempts_per_game: 120.5, avg_rushing_yards_per_attempt: 120.5, longest_rush: "some longest_rush", player: "some player", position: "some position", rushing_20_plus_yards_each: 42, rushing_40_plus_yards_each: 42, rushing_first_down_percentage: 120.5, rushing_first_downs: 42, rushing_fumbles: 42, rushing_yards_per_game: 120.5, team: "some team", total_rushing_touchdowns: 42, total_rushing_yards: 42}

      assert {:ok, %Record{} = record} = Football.create_record(valid_attrs)
      assert record.avg_rushing_attempts_per_game == 120.5
      assert record.avg_rushing_yards_per_attempt == 120.5
      assert record.longest_rush == "some longest_rush"
      assert record.player == "some player"
      assert record.position == "some position"
      assert record.rushing_20_plus_yards_each == 42
      assert record.rushing_40_plus_yards_each == 42
      assert record.rushing_first_down_percentage == 120.5
      assert record.rushing_first_downs == 42
      assert record.rushing_fumbles == 42
      assert record.rushing_yards_per_game == 120.5
      assert record.team == "some team"
      assert record.total_rushing_touchdowns == 42
      assert record.total_rushing_yards == 42
    end

    test "create_record/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Football.create_record(@invalid_attrs)
    end

    test "update_record/2 with valid data updates the record" do
      record = record_fixture()
      update_attrs = %{avg_rushing_attempts_per_game: 456.7, avg_rushing_yards_per_attempt: 456.7, longest_rush: "some updated longest_rush", player: "some updated player", position: "some updated position", rushing_20_plus_yards_each: 43, rushing_40_plus_yards_each: 43, rushing_first_down_percentage: 456.7, rushing_first_downs: 43, rushing_fumbles: 43, rushing_yards_per_game: 456.7, team: "some updated team", total_rushing_touchdowns: 43, total_rushing_yards: 43}

      assert {:ok, %Record{} = record} = Football.update_record(record, update_attrs)
      assert record.avg_rushing_attempts_per_game == 456.7
      assert record.avg_rushing_yards_per_attempt == 456.7
      assert record.longest_rush == "some updated longest_rush"
      assert record.player == "some updated player"
      assert record.position == "some updated position"
      assert record.rushing_20_plus_yards_each == 43
      assert record.rushing_40_plus_yards_each == 43
      assert record.rushing_first_down_percentage == 456.7
      assert record.rushing_first_downs == 43
      assert record.rushing_fumbles == 43
      assert record.rushing_yards_per_game == 456.7
      assert record.team == "some updated team"
      assert record.total_rushing_touchdowns == 43
      assert record.total_rushing_yards == 43
    end

    test "update_record/2 with invalid data returns error changeset" do
      record = record_fixture()
      assert {:error, %Ecto.Changeset{}} = Football.update_record(record, @invalid_attrs)
      assert record == Football.get_record!(record.id)
    end

    test "delete_record/1 deletes the record" do
      record = record_fixture()
      assert {:ok, %Record{}} = Football.delete_record(record)
      assert_raise Ecto.NoResultsError, fn -> Football.get_record!(record.id) end
    end

    test "change_record/1 returns a record changeset" do
      record = record_fixture()
      assert %Ecto.Changeset{} = Football.change_record(record)
    end
  end
end
