defmodule RushWeb.RecordLiveTest do
  use RushWeb.ConnCase

  import Phoenix.LiveViewTest
  import Rush.FootballFixtures

  defp create_record(_) do
    record = record_fixture()
    %{record: record}
  end

  describe "Index" do
    setup [:create_record]

    test "lists all records", %{conn: conn, record: record} do
      {:ok, _index_live, html} = live(conn, Routes.record_index_path(conn, :index))

      assert html =~ record.player
    end

    test "filters records by player name", %{conn: conn, record: record} do
      {:ok, view, _html} = live(conn, Routes.record_index_path(conn, :index))

      assert view |> render_change("filter", %{"filter" => %{"player" => record.player}}) =~
               record.player

      refute view |> render_change("filter", %{"filter" => %{"player" => "invalid name"}}) =~
               record.player
    end

    test "sort by total_rushing_yards, longest_rush, and total_rushing_touchdowns", %{
      conn: conn,
      record: record
    } do
      {:ok, view, _html} = live(conn, Routes.record_index_path(conn, :index))

      Enum.each([:total_rushing_yards, :longest_rush, :total_rushing_touchdowns], fn each ->
        assert view
               |> render_change("sort", %{
                 "sort" => %{"sort_by" => each, "order_by" => "smallest"}
               }) =~
                 record.player
      end)
    end

    test "sort by nothing", %{
      conn: conn,
      record: record
    } do
      {:ok, view, _html} = live(conn, Routes.record_index_path(conn, :index))

      assert view
             |> render_change("sort", %{
               "sort" => %{"sort_by" => "", "order_by" => ""}
             }) =~
               record.player
    end
  end
end
