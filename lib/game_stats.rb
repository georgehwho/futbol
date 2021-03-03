require_relative 'game'
require_relative 'load_csv'
require_relative 'math'

class GameStats
  include LoadCSV
  include Math

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

  ### start of game stats ###
  def highest_total_score
    highest_scoring_game = games.max_by { |game| game.total_score}
    highest_scoring_game.total_score
  end

  def lowest_total_score
    games.min_by { |game| game.total_score }.total_score
  end

  def percentage_home_wins
    total_home_games_won = games.find_all { |game| game.home_win? }.size
    percentage(total_home_games_won, games.size)
  end

  def percentage_visitor_wins
    total_visitor_games_won = games.find_all { |game| game.away_win? }.size
    percentage(total_visitor_games_won, games.size)
  end

  def percentage_ties
    total_games_tied = games.find_all { |game| game.tie? }.size
    percentage(total_games_tied, games.size)
  end

  def count_of_games_by_season
    games.group_by(&:season).transform_values(&:size)
  end

  def average_goals_per_game(input_games = games)
    all_scores = input_games.sum(&:total_score)
    percentage(all_scores, input_games.size)
  end

  def average_goals_by_season
    games_by_season = games.group_by(&:season)
    games_by_season.transform_values do |season_games|
      average_goals_per_game(season_games)
    end
  end
  ### end of game stats ###

  def find_games_by_team_id(id)
    games.find_all do |game|
      game.away_team_id == id || game.home_team_id == id
    end
  end

  def find_games_won(list_of_games, id)
    games_won = []
    list_of_games.each do |game|
      if game.away_team_id == id && game.away_win?
        games_won << game
      elsif game.home_team_id == id && game.home_win?
        games_won << game
      end
    end
    games_won
  end

  def best_season(id)
    games_played = find_games_by_team_id(id)
    games_won = find_games_won(games_played, id)
    games_by_season = games_won.group_by(&:season)
    games_by_season.max_by { |season, games| games.size }[0]
  end

  def worst_season(id)
    games_played = find_games_by_team_id(id)
    games_won = find_games_won(games_played, id)
    games_by_season = games_won.group_by(&:season)
    games_by_season.min_by { |season, games| games.size }[0]
  end

  def group_by_season
    games.group_by(&:season)
  end

  def game_ids_by_season
    group_by_season.transform_values do |games|
      games.map(&:game_id)
    end
  end

  def opponent_team_ids(team_id)
    team_games = games.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
    team_games.map do |game|
      team_id == game.away_team_id ? game = game.home_team_id : game = game.away_team_id
    end.uniq
  end
end