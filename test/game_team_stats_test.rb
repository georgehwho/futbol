require "./test/test_helper"

class GameTeamStatsTest < Minitest::Test
  attr_reader :game_teams_stats,
              :stat_tracker

  def setup
    @locations = {
      games: './test/truncated_csv/games_truncated.csv',
      teams: './data/teams.csv',
      game_teams: './test/truncated_csv/game_teams_truncated.csv'
    }
    @stat_tracker = StatTracker.new(@locations)
    @game_teams_stats = stat_tracker.game_team_stats
  end

  def test_it_exists
    assert_instance_of GameTeamStats, game_teams_stats
  end

  def test_it_has_readable_attributes
    assert_equal stat_tracker, game_teams_stats.stat_tracker
    assert_equal 50, game_teams_stats.game_teams.size
  end

  def test_it_can_load_from_csv
    first_row = CSV.open('./test/truncated_csv/game_teams_truncated.csv', headers: true, header_converters: :symbol ) {
      |csv| csv.first
    }

    first_game_teams = GameTeam.new(first_row)

    assert_instance_of Array, game_teams_stats.game_teams
  end

  def test_it_has_an_array_by_team_id
    assert_equal 7, game_teams_stats.array_by_team_id('17').count

  end
  def test_it_has_number_of_wins
    assert_equal 4, game_teams_stats.number_of_wins('17')
  end

  def test_it_can_find_an_average_win_percentage
    assert_equal 0.57, game_teams_stats.average_win_percentage('17')
  end
end
