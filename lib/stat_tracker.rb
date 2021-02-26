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

  def highest_total_score
    game_stats.highest_total_score
  end

  def lowest_total_score
    game_stats.lowest_total_score
  end

end
