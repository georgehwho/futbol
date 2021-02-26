require "./test/test_helper"


class TeamTest < Minitest::Test
  def setup
    @arsenal = Team.new({
                        team_id: 1,
                        franchiseid: 11,
                        teamname: "Arsenal",
                        abbreviation: "UK",
                        stadium: "Stadium in the UK",
                        link: "/api/v1/teams/1"
                        })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Team, @arsenal
    assert_equal 1, @arsenal.team_id
    assert_equal 11, @arsenal.franchise_id
    assert_equal "Arsenal", @arsenal.team_name
    assert_equal "Stadium in the UK", @arsenal.stadium
    assert_equal "/api/v1/teams/1", @arsenal.link
  end
end
