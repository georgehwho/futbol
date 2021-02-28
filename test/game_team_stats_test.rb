require "./test/test_helper"

class GameTeamStatsTest < Minitest::Test
  attr_reader :game_team_stats,
              :stat_tracker

  def setup
    @locations = {
      games: './test/truncated_csv/games_truncated.csv',
      teams: './data/teams.csv',
      game_teams: './test/truncated_csv/game_teams_truncated.csv'
    }
    @stat_tracker = StatTracker.new(@locations)
    @game_team_stats = stat_tracker.game_team_stats
  end

  def test_it_exists
    assert_instance_of GameTeamStats, game_team_stats
  end

  def test_it_has_readable_attributes
    assert_equal stat_tracker, game_team_stats.stat_tracker
    assert_equal 50, game_team_stats.game_teams.size
  end

  def test_it_can_load_from_csv
    first_row = CSV.open('./test/truncated_csv/game_teams_truncated.csv', headers: true, header_converters: :symbol ) {
      |csv| csv.first
    }

    first_game_teams = GameTeam.new(first_row)

    assert_instance_of Array, game_team_stats.game_teams
  end

  def test_it_can_count_teams
    assert_equal 8, game_team_stats.count_of_teams
  end
end
