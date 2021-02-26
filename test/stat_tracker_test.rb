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

	def test_it_can_find_the_highest_total_score
		# skip
		assert_equal 6, @stat_tracker.highest_total_score
	end

	def test_it_can_find_the_lowest_total_score
		# skip
		assert_equal 1, @stat_tracker.lowest_total_score
	end
end
