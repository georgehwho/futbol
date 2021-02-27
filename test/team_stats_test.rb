require './test/test_helper'

class TestStatsTest < Minitest::Test
  attr_reader :team_stats,
              :stat_tracker

  def setup
    @locations = {
      games: './test/truncated_csv/games_truncated.csv',
      teams: './data/teams.csv',
      game_teams: './test/truncated_csv/game_teams_truncated.csv'
    }
    @stat_tracker = StatTracker.new(@locations)
    @team_stats = stat_tracker.team_stats
  end

  def test_it_exists
    assert_instance_of TeamStats, team_stats
  end

  def test_it_has_readable_attributes
    assert_equal stat_tracker, team_stats.stat_tracker
    assert_equal 32, team_stats.teams.size
    assert_equal 32, team_stats.teams_hash.size
  end

  def test_it_can_create_teams
    team_stats.stubs(:load_csv).returns([Team.new( { abbreviation: "ATL",
                                                    franchiseId: 0,
                                                    link: "/api/v1/teams/1",
                                                    stadium: "Mercedes-Benz Stadium",
                                                    teamName: nil,
                                                    team_id: 1 } ) ] )
    team_stats.create_teams_array('')
    assert_equal 'ATL', team_stats.teams.first.abbreviation
  end

  def test_it_can_create_hash
    assert_instance_of Hash, team_stats.create_teams_hash
  end

  def test_it_can_find_a_team_by_id
    assert_instance_of Team, team_stats.find_by_id("1")
  end

  def test__it_can_count_total_teams
    assert_equal 32, team_stats.count
  end

  def test_it_has_team_information
    expected19 = {"franchise_id" => "18",
                 "team_name" => "Philadelphia Union",
                "abbreviation" => "PHI",
                "link" => "/api/v1/teams/19",
                "team_id" => "19" }
  assert_equal expected19, team_stats.team_information("19")
  end
end
