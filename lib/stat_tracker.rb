require_relative 'game_stats'
require_relative 'game_team_stats'
require_relative 'team_stats'

class StatTracker
  attr_reader :game_stats,
              :game_team_stats,
              :team_stats

  def initialize(locations)
    @game_stats      = GameStats.new(locations[:games], self)
    @game_team_stats = GameTeamStats.new(locations[:game_teams], self)
    @team_stats      = TeamStats.new(locations[:teams], self)
  end

  def self.from_csv(locations)
    new(locations)
  end

  def find_team_name_by_id(id)
    team_stats.find_team_name_by_id(id)
  end

  def game_ids_by_season(season)
    game_stats.game_ids_by_season(season)
  end

  ### Game Stats ###
  def highest_total_score
    game_stats.highest_total_score
  end

  def lowest_total_score
    game_stats.lowest_total_score
  end

  def percentage_home_wins
    game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    game_stats.percentage_visitor_wins
  end

  def percentage_ties
    game_stats.percentage_ties
  end

  def count_of_games_by_season
    game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    game_stats.average_goals_per_game
  end

  def average_goals_by_season
    game_stats.average_goals_by_season
  end

  def best_season(team_id)
    game_stats.best_season(team_id)
  end

  def worst_season(team_id)
    game_stats.worst_season(team_id)
  end

  ### Team Stats ###
  def team_info(team_id)
    team_stats.team_information(team_id)
  end

  def average_win_percentage(id)
    game_team_stats.average_win_percentage(id)
  end

  def most_goals_scored(id)
    game_team_stats.most_goals_scored(id)
  end

  def fewest_goals_scored(id)
    game_team_stats.fewest_goals_scored(id)
  end

  def favorite_opponent(id)
    game_team_stats.favorite_opponent(id)
  end

  def rival(id)
    game_team_stats.rival(id)
  end
  ### League Statistics ###
  def count_of_teams
    game_team_stats.count_of_teams
  end

  def best_offense
    game_team_stats.best_offense
  end

  def worst_offense
    game_team_stats.worst_offense
  end

  def highest_scoring_visitor
    game_team_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    game_team_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    game_team_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    game_team_stats.lowest_scoring_home_team
  end

  ### Season Statistics ###
  def winningest_coach(season)
    game_team_stats.winningest_coach(season)
  end

  def worst_coach(season)
    game_team_stats.worst_coach(season)
  end

  def most_tackles(season)
    game_team_stats.most_tackles(season)
  end

  def fewest_tackles(season)
    game_team_stats.fewest_tackles(season)
  end

  def most_accurate_team(season)
    game_team_stats.most_accurate_team(season)
  end

  def least_accurate_team(season)
    game_team_stats.least_accurate_team(season)
  end
end
