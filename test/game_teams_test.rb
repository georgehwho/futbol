require "./test/test_helper"

class GameTeamsTest  < Minitest::Test

def setup
  @chargers = GameTeams.new({
                  game_id: 1,
                  team_id: 2,
                  HoA: "away",
                  result: "WIN",
                  settled_in: "OT",
                  head_coach: "Olivia",
                  goals: 22,
                  shots: 7,
                  tackles: 2,
                  pim: 1,
                  powerPlayGoalsOpportunities: 4,
                  powerPlayGoals: 3,
                  faceOffWinPercentage: 99.9,
                  giveaways: 5,
                  takeaways: 6
    })
end
