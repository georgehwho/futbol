require_relative 'team'
require_relative 'load_csv'

class TeamStats
  include LoadCSV

  attr_reader :teams,
              :teams_hash,
              :stat_tracker

  def initialize(file_path, stat_tracker)
    @stat_tracker = stat_tracker
    @teams        = []
    @teams_hash   = {}
    create_teams_array(file_path)
    create_teams_hash
  end

  def create_teams_array(file_path)
    @teams = load_csv(file_path, Team)
  end

  def create_teams_hash
    @teams_hash = teams.map{ |team| [team.team_id, team] }.to_h
  end

  def find_by_id(id)
    @teams_hash[id]
  end
end
