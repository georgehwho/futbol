class GameTeam
  attr_reader :game_id,
              :team_id,
              :HoA,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :powerPlayGoalsOpportunities,
              :powerPlayGoals,
              :faceOffWinPercentage,
              :giveaways,
              :takeaways

  def initialize(data)
<<<<<<< HEAD
    @game_id                     = data[:game_id].to_i
=======
    @game_id                     = data[:game_id]
>>>>>>> db591b148d801ee2cb1b06fc24a120e850bc9c2c
    @team_id                     = data[:team_id]
    @HoA                         = data[:HoA]
    @result                      = data[:result]
    @settled_in                  = data[:settled_in]
    @head_coach                  = data[:head_coach]
    @goals                       = data[:goals].to_i
    @shots                       = data[:shots].to_i
    @tackles                     = data[:tackles].to_i
    @pim                         = data[:pim].to_i
    @powerPlayGoalsOpportunities = data[:powerPlayGoalsOpportunities].to_i
    @powerPlayGoals              = data[:powerPlayGoals].to_i
    @faceOffWinPercentage        = data[:faceOffWinPercentage].to_f
    @giveaways                   = data[:giveaways].to_i
    @takeaways                   = data[:takeaways].to_i
  end
end
