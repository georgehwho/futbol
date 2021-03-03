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
    assert_equal 9, game_team_stats.team_id_hash.size
    assert_equal 2, game_team_stats.hoa_hash.size
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
    assert_instance_of Hash, game_team_stats.group_by_team_id
  end

  def test_it_can_group_by_hoa
    assert_instance_of Hash, game_team_stats.group_by_hoa
  end

  def test_it_can_find_average_goals
    # skip
    assert_equal 1.9, game_team_stats.average_goals_of_game_team(game_team_stats.game_teams)
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

  def test_it_can_find_an_average_win_percentage
    assert_equal 0.57, game_team_stats.average_win_percentage('17')
  end

  def test_winningest_coach
    assert_equal "Claude Julien", game_team_stats.winningest_coach('20122013')
  end

  def test_worst_coach
    assert_equal "John Tortorella", game_team_stats.worst_coach('20142015')
  end

  def test_tackles_by_team
    assert_equal 104, game_team_stats.tackles_by_team('17')
  end

  def test_it_has_most_tackles
    assert_equal "New England Revolution", game_team_stats.most_tackles('20122013')
  end

  def test_it_has_fewest_tackles
    assert_equal "Orlando City SC", game_team_stats.fewest_tackles('20122013')
  end

  def test_accuracy_of_game_teams
    assert_equal 1.00, game_team_stats.accuracy_of_game_teams('17')
  end

  def test_it_has_a_most_accurate_team
    assert_equal "New York City FC" , game_team_stats.most_accurate_team('20122013')
  end

  def test_it_has_a_least_accurate_team
    assert_equal "Sporting Kansas City", game_team_stats.least_accurate_team('20122013')
  end

  def test_favorite_opponents
    assert_equal 'New England Revolution', game_team_stats.favorite_opponent('17')
  end

  def test_rival
    assert_equal 'New England Revolution', game_team_stats.rival('17')
  end

  def test_most_goals_scored
    assert_equal 2, game_team_stats.most_goals_scored('3')
  end

  def test_fewest_goals_scored
    assert_equal 1, game_team_stats.fewest_goals_scored('3')
  end
end
