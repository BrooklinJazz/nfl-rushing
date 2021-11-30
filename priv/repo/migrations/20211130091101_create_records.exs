defmodule Rush.Repo.Migrations.CreateRecords do
  use Ecto.Migration

  def change do
    create table(:records) do
      add :player, :string
      add :team, :string
      add :position, :string
      add :avg_rushing_attempts_per_game, :float
      add :total_rushing_yards, :integer
      add :avg_rushing_yards_per_attempt, :float
      add :rushing_yards_per_game, :float
      add :total_rushing_touchdowns, :integer
      add :longest_rush, :string
      add :rushing_first_downs, :integer
      add :rushing_first_down_percentage, :float
      add :rushing_20_plus_yards_each, :integer
      add :rushing_40_plus_yards_each, :integer
      add :rushing_fumbles, :integer

      timestamps()
    end
  end
end
