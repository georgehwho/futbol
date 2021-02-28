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

  def count_of_teams
    game_teams.uniq do |team|
      team.team_id
    end.size
  end

  def group_game_teams_by_team_id
    game_teams.group_by { |team| team.team_id }
  end

  def average_goals_of_game_team(list_of_game_teams = game_teams)
    all_goals = list_of_game_teams.sum(&:goals)
    (all_goals / list_of_game_teams.size.to_f).round(2)
  end

  def best_offense
    team_with_best_offense = group_game_teams_by_team_id.max_by do |team_id, game_team|
      average_goals_of_game_team(game_team)
    end
    best_offense_team_id = team_with_best_offense[0]
    stat_tracker.team_stats.find_by_id(best_offense_team_id).team_name
  end
end
