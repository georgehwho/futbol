require_relative 'team'
require_relative 'load_csv'
require_relative 'math'

class TeamStats
  include LoadCSV
  include Math

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

  def find_team_name_by_id(id)
    @teams_hash[id].team_name
  end

  def team_information(team_id)
    team_data = @teams_hash[team_id]
     {
      "franchise_id" => team_data.franchise_id.to_s,
      "team_name" => team_data.team_name,
      "abbreviation" => team_data.abbreviation,
      "link" => team_data.link,
      "team_id" => team_id.to_s
     }
  end

end
