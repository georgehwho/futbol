require "./test/test_helper"

class GameTeamStatsTest < Minitest::Test
  attr_reader :game_teams_stats,
              :stat_tracker

  def setup
    @stat_tracker = mock
    @game_teams_stats = GameTeamsStats.new('./data/game_teams_truncated.csv', @stat_tracker)
  end

  def test_it_exists
    assert_instance_of GameTeamStats, game_teams_stats
  end

  def test_it_has_readable_attributes
    assert_equal stat_tracker, game_teams_stats.stat_tracker
    assert_equal 50, game_teams_stats.games.size
  end

  def test_it_can_load_from_csv
    first_row = CSV.open('./data/game_teams_truncated.csv', headers: true, header_converters: :symbol ) {
      |csv| csv.first
    }

    first_game_teams = GameTeam.new(first_row)

    assert_instance_of Array, game_teams_stats.game_teams
  end
end
