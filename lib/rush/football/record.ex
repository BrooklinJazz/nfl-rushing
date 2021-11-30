defmodule Rush.Football.Record do
  use Ecto.Schema
  import Ecto.Changeset

  schema "records" do
    field :avg_rushing_attempts_per_game, :float
    field :avg_rushing_yards_per_attempt, :float
    field :longest_rush, :string
    field :player, :string
    field :position, :string
    field :rushing_20_plus_yards_each, :integer
    field :rushing_40_plus_yards_each, :integer
    field :rushing_first_down_percentage, :float
    field :rushing_first_downs, :integer
    field :rushing_fumbles, :integer
    field :rushing_yards_per_game, :float
    field :team, :string
    field :total_rushing_touchdowns, :integer
    field :total_rushing_yards, :integer

    timestamps()
  end

  @doc false
  def changeset(record, attrs) do
    record
    |> cast(attrs, [:player, :team, :position, :avg_rushing_attempts_per_game, :total_rushing_yards, :avg_rushing_yards_per_attempt, :rushing_yards_per_game, :total_rushing_touchdowns, :longest_rush, :rushing_first_downs, :rushing_first_down_percentage, :rushing_20_plus_yards_each, :rushing_40_plus_yards_each, :rushing_fumbles])
    |> validate_required([:player, :team, :position, :avg_rushing_attempts_per_game, :total_rushing_yards, :avg_rushing_yards_per_attempt, :rushing_yards_per_game, :total_rushing_touchdowns, :longest_rush, :rushing_first_downs, :rushing_first_down_percentage, :rushing_20_plus_yards_each, :rushing_40_plus_yards_each, :rushing_fumbles])
  end
end
