require "./test/test_helper"

class GameStatsTest < Minitest::Test
  attr_reader :game_stats,
              :stat_tracker

  def setup
    @stat_tracker = mock
    @game_stats = GameStats.new('./data/games_truncated.csv', @stat_tracker)
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
    first_row = CSV.open('./data/games_truncated.csv', headers: true, header_converters: :symbol ) {
      |csv| csv.first
    }

    first_game = Game.new(first_row)

    assert_equal first_game.game_id, @game_stats.create_games_array('./data/games_truncated.csv').first.game_id
    assert_instance_of Array, @game_stats.games
  end

  def test_it_can_also_have_a_games_hash
    assert_instance_of Hash, @game_stats.games_hash
  end

  def test_it_can_find_a_game_by_id
    assert_instance_of Game, game_stats.find_by_id(2012030221)
  end

  def test_game_can_find_highest_total_score
    # skip
    assert_equal 6, @game_stats.highest_total_score
  end
end
