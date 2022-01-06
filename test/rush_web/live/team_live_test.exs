defmodule RushWeb.TeamLiveTest do
  use RushWeb.ConnCase

  import Phoenix.LiveViewTest
  import Rush.FootballFixtures

  defp create_record(_) do
    record = record_fixture()
    %{record: record}
  end

  describe "Index" do
    test "lists all records", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.team_index_path(conn, :index))
      record = record_fixture()

      assert html =~ record.team
    end
  end
end
