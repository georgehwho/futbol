require_relative 'game_stats'

class StatTracker
  attr_reader :game_stats

  def self.from_csv(locations)
  	new(locations)
  end

  def initialize(locations)
    @game_stats = GameStats.new(locations[:games])
    # @game_teams = load_csv(locations[:game_teams], GameTeam)
    # @teams = load_csv(locations[:teams], Team)
  end

  def highest_total_score
    game_stats.highest_total_score
  end

end
