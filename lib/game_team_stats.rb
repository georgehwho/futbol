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
end
