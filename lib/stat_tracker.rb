require_relative 'game_stats'

class StatTracker
  attr_reader :game_stats

  def self.from_csv(locations)
  	new(locations)
  end

  def initialize(locations)
    @game_stats = GameStats.new(locations[:games], self)
    @game_teams = GameTeamsStats.new(locations[:game_teams], self)
    @teams = TeamsStats.new(locations[:teams], self)
  end

  def highest_total_score
    game_stats.highest_total_score
  end

end
