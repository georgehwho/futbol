require_relative 'game'
require_relative 'load_csv'

class GameStats
  include LoadCSV

  attr_reader :games

  def initialize(file_path)
    @games = load_csv(file_path, Game)
  end

  def highest_total_score
    highest_scoring_game = games.max_by { |game| game.total_score}
    highest_scoring_game.total_score
  end
end
