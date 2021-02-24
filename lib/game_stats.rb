require_relative 'game'
require_relative 'load_csv'

class GameStats
  include LoadCSV

  attr_reader :games

  def initialize(file_path)
    @games = load_csv(file_path, Game)
  end

  def highest_total_score
    'hello, world'
  end
end
