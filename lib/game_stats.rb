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

  ### Required Queries ###
  def highest_total_score
    highest_scoring_game = games.max_by { |game| game.total_score}
    highest_scoring_game.total_score
  end

  def lowest_total_score
    games.min_by { |game| game.total_score }.total_score
  end

  def percentage_home_wins
    total_home_games_won = games.find_all { |game| game.home_win? }.size
    percentage_of_games(total_home_games_won)
  end

  def percentage_visitor_wins
    total_visitor_games_won = games.find_all { |game| game.away_win? }.size
    percentage_of_games(total_visitor_games_won)
  end

  def percentage_ties
    total_games_tied = games.find_all { |game| game.tie? }.size
    percentage_of_games(total_games_tied)
  end

  def percentage_of_games(input)
    (input / games.size.to_f).round(2)
  end

  def count_of_games_by_season
    hash = {}
    games.map do |game|
      hash[game.season] = 0 if hash[game.season].nil?
      hash[game.season] += 1
    end
    hash
  end
end
