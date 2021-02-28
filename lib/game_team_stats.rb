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

  def array_by_team_id(id)
    all_games =[]
    @game_teams.each do |game_team|
       if game_team.team_id == id
         all_games << game_team
      end
    end
    all_games
  end

  def number_of_wins(id)
    array_by_team_id(id).find_all do  |game_team|
      game_team.result == "WIN"
    end.count
  end

  def average_win_percentage(id)
  (number_of_wins(id) /array_by_team_id(id).count.to_f).round(2)
  end
end
