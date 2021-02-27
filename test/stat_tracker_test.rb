require "./test/test_helper"

class StatTrackerTest < Minitest::Test

	def setup
		@locations = {
		  games: './test/truncated_csv/games_truncated.csv',
		  teams: './data/teams.csv',
		  game_teams: './test/truncated_csv/game_teams_truncated.csv'
		}
		@stat_tracker = StatTracker.from_csv(@locations)
	end

	def test_it_exists
		stat_tracker = StatTracker.from_csv(@locations)
		assert_instance_of StatTracker, stat_tracker
	end

	### Game Stat Test ###
	def test_it_can_find_the_highest_total_score
		# skip
		assert_equal 6, @stat_tracker.highest_total_score
	end

	def test_it_can_find_the_lowest_total_score
		# skip
		assert_equal 1, @stat_tracker.lowest_total_score
	end

	def test_it_knows_percentage_of_home_wins
		assert_equal 0.66, @stat_tracker.percentage_home_wins
	end

	def test_it_knows_percentage_of_visitor_wins
		assert_equal 0.32, @stat_tracker.percentage_visitor_wins
	end

	def test_it_knows_percentage_of_ties
		assert_equal 0.02, @stat_tracker.percentage_ties
	end

	### Team Stat Test ###
	def test_it_can_count_teams
		assert_equal 32, @stat_tracker.count_of_teams
	end

	def test_it_can_get_team_info
		expected = {
			"team_id" => "18",
			"franchise_id" => "34",
			"team_name" => "Minnesota United FC",
			"abbreviation" => "MIN",
			"link" => "/api/v1/teams/18"
		}
		assert_equal expected, @stat_tracker.team_info("18")
	end


end
