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
    # skip
    assert_equal stat_tracker, game_team_stats.stat_tracker
    assert_equal 52, game_team_stats.game_teams.size
    assert_equal 9, game_team_stats.game_teams_hash.size
  end

  def test_it_can_load_from_csv
    first_row = CSV.open('./test/truncated_csv/game_teams_truncated.csv', headers: true, header_converters: :symbol ) {
      |csv| csv.first
    }

    first_game_teams = GameTeam.new(first_row)

    assert_instance_of Array, game_team_stats.game_teams
  end

  def test_it_can_count_teams
    # skip
    assert_equal 9, game_team_stats.count_of_teams
  end

  def test_it_can_group_by_team_id
    assert_instance_of Hash, game_team_stats.group_game_teams_by_team_id
  end

  def test_it_can_find_average_goals
    # skip
    assert_equal 1.9, game_team_stats.average_goals_of_game_team
  end

  def test_it_can_find_the_team_with_the_best_offense
    assert_equal "New York City FC", game_team_stats.best_offense
  end

  def test_it_can_find_the_team_with_the_worst_offense
    assert_equal "Sporting Kansas City", game_team_stats.worst_offense
  end

  def test_it_can_find_the_highest_scoring_visitor
    assert_equal "FC Dallas", game_team_stats.highest_scoring_visitor
  end

  def test_it_can_find_the_highest_scoring_home_team
    assert_equal "New York City FC", game_team_stats.highest_scoring_home_team
  end

  def test_it_can_find_the_lowest_scoring_visitor
    assert_equal "Sporting Kansas City", game_team_stats.lowest_scoring_visitor
  end

  def test_it_can_find_the_lowest_scoring_home_team
    assert_equal "Sporting Kansas City", game_team_stats.lowest_scoring_home_team
  end

  def test_it_has_an_array_by_team_id
    assert_equal 7, game_team_stats.array_by_team_id('17').count

  end
  def test_it_has_number_of_wins
    assert_equal 4, game_team_stats.number_of_wins('17')
  end

  def test_it_can_find_an_average_win_percentage
    assert_equal 0.57, game_team_stats.average_win_percentage('17')
  end

  def test_find_team_win_percentage
    assert_equal 0.25, game_team_stats.find_team_win_percentage(game_team_stats.game_teams, '30')
  end

  def test_winningest_coach
    assert_equal "Claude Julien", game_team_stats.winningest_coach('20122013')
  end

  # def test_worst_coach
  #   assert_equal "John Tortorella", game_team_stats.worst_coach('20142015')
  # end
end
