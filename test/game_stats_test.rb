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
  end


end
