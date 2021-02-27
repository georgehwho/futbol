require "./test/test_helper"

class GameStatsTest < Minitest::Test
  attr_reader :game_stats,
              :stat_tracker

  def setup
    @locations = {
      games: './test/truncated_csv/games_truncated.csv',
      teams: './data/teams.csv',
      game_teams: './test/truncated_csv/game_teams_truncated.csv'
    }
    @stat_tracker = StatTracker.new(@locations)
    @game_stats = stat_tracker.game_stats
  end

  def test_it_exists
    assert_instance_of GameStats, game_stats
  end

  def test_it_has_readable_attributes
    assert_equal stat_tracker, game_stats.stat_tracker
    assert_equal 50, game_stats.games.size
    assert_equal 50, game_stats.games_hash.size
  end

  def test_it_can_load_from_csv
    # skip
    first_row = CSV.open('./test/truncated_csv/games_truncated.csv', headers: true, header_converters: :symbol ) {
      |csv| csv.first
    }

    first_game = Game.new(first_row)

    assert_equal first_game.game_id, @game_stats.create_games_array('./test/truncated_csv/games_truncated.csv').first.game_id
    assert_instance_of Array, @game_stats.games
  end

  def test_it_can_also_have_a_games_hash
    assert_instance_of Hash, @game_stats.games_hash
  end

  def test_it_can_find_a_game_by_id
    assert_instance_of Game, game_stats.find_by_id('2012030221')
  end

  def test_it_can_find_a_team_by_id
    assert_instance_of Team, game_stats.stat_tracker.team_stats.find_by_id("1")
    assert_equal 'Atlanta United', game_stats.stat_tracker.team_stats.find_by_id("1").team_name
  end

  def test_game_can_find_highest_total_score
    # skip
    assert_equal 6, @game_stats.highest_total_score
  end

  def test_game_can_find_lowest_total_score
    # skip
    assert_equal 1, @game_stats.lowest_total_score
  end

  def test_it_knows_percentage_of_home_wins
    assert_equal 0.66, game_stats.percentage_home_wins
  end

  def test_it_knows_percentage_of_visitor_wins
    assert_equal 0.32, game_stats.percentage_visitor_wins
  end

  def test_it_knows_percentage_of_ties
    assert_equal 0.02, game_stats.percentage_ties
  end

  def test_it_knows_how_to_count_games_by_season
    expected = {
      "20122013"=>49,
      "20142015"=>1
    }
    assert_equal expected, game_stats.count_of_games_by_season
  end
end
