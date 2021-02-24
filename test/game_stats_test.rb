require "./test/test_helper"
require "./lib/game_stats"

class GameStatsTest < Minitest::Test
  def setup
    @game_stats = GameStats.new('./data/games_truncated.csv')
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_can_load_from_csv
    # skip
    first_row = CSV.open('./data/games_truncated.csv', headers: true, header_converters: :symbol ) {
      |csv| csv.first
    }

    first_game = Game.new(first_row)

    assert_equal first_game.game_id, @game_stats.games.first.game_id
    assert_instance_of Array, @game_stats.game
  end

  def test_it_can_also_have_a_games_hash
    assert_instance_of Hash, @game_stats.games_hash
  end

  def test_game_can_find_highest_total_score
    assert_equal 6, @game_stats.highest_total_score
  end
end
