require "./test/test_helper"

class GameTeamTest  < Minitest::Test

  def setup
    @chargers = GameTeam.new({
                    game_id: "1",
                    team_id: "2",
                    HoA: "away",
                    result: "WIN",
                    settled_in: "OT",
                    head_coach: "Olivia",
                    goals: "22",
                    shots: "7",
                    tackles: "2",
                    pim: "1",
                    powerPlayGoalsOpportunities: "4",
                    powerPlayGoals: "3",
                    faceOffWinPercentage: "99.9",
                    giveaways: "5",
                    takeaways: "6"
      })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameTeam, @chargers
    assert_equal 1 , @chargers.game_id
    assert_equal 2, @chargers.team_id
    assert_equal "away", @chargers.HoA
    assert_equal "WIN", @chargers.result
    assert_equal "OT", @chargers.settled_in
    assert_equal "Olivia", @chargers.head_coach
    assert_equal 22, @chargers.goals
    assert_equal 7, @chargers.shots
    assert_equal 2, @chargers.tackles
    assert_equal 1, @chargers.pim
    assert_equal 4, @chargers.powerPlayGoalsOpportunities
    assert_equal 3, @chargers.powerPlayGoals
    assert_equal 99.9, @chargers.faceOffWinPercentage
    assert_equal 5, @chargers.giveaways
    assert_equal 6, @chargers.takeaways
  end
end
