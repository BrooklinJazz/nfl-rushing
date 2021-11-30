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

      assert html =~ "Listing Records"
      assert html =~ record.longest_rush
    end
  end
end
