require "./test/test_helper"
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

	def setup
		@locations = {
		  games: './data/games.csv',
		  teams: './data/teams.csv',
		  game_teams: './data/game_teams.csv'
		}
		@stat_tracker = StatTracker.from_csv(@locations)
	end

	def test_it_exists
		stat_tracker = StatTracker.from_csv(@locations)
		assert_instance_of StatTracker, stat_tracker
	end

	def test_it_can_find_the_highest_total_score
		assert_equal 11, @stat_tracker.highest_total_score
	end
end
