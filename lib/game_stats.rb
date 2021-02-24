require_relative 'game'
require_relative 'load_csv'

class GameStats
  include LoadCSV

  attr_reader :games,
              :games_hash

  def initialize(file_path)
    @games = load_csv(file_path, Game)
    @games_hash = games.map { |game| [game.game_id, game] }.to_h
  end

  def highest_total_score
    highest_scoring_game = games.max_by { |game| game.total_score}
    highest_scoring_game.total_score
  end
end
