require_relative 'game'
require_relative 'load_csv'

class GameStats
  include LoadCSV

  attr_reader :games,
              :games_hash,
              :stat_tracker

  def initialize(file_path, stat_tracker)
    @stat_tracker = stat_tracker
    @games        = []
    @games_hash   = {}
    create_games_array(file_path)
    create_games_hash
  end

  def create_games_array(file_path)
    @games = load_csv(file_path, Game)
  end

  def create_games_hash
    @games_hash = games.map { |game| [game.game_id, game] }.to_h
  end

  def find_by_id(id)
   @games_hash[id]
 end

  def highest_total_score
    highest_scoring_game = games.max_by { |game| game.total_score}
    highest_scoring_game.total_score
  end
end
