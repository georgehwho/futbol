require_relative 'game_team'
require_relative 'load_csv'

class GameTeamStats
  include LoadCSV

  attr_reader :game_teams,
              :stat_tracker

  def initialize(file_path, stat_tracker)
    @stat_tracker = stat_tracker
    @game_teams   = []
    create_game_teams_array(file_path)
  end

  def create_game_teams_array(file_path)
    @game_teams = load_csv(file_path, GameTeam)
  end

  # percentage_home_wins	Percentage of games that a home team has won (rounded to the nearest 100th)	Float
  def percentage_home_wins

  end
end
