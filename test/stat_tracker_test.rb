require "./test/test_helper"
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

	def setup
		@locations = {
		  games: './data/games.csv',
		  teams: './data/teams.csv',
		  game_teams: './data/game_teams.csv'
		}
	end 

	def test_it_exists
		stat_tracker = StatTracker.new(@locations)

		assert_instance_of StatTracker, stat_tracker
	end 

	def test_it_can_open_from_csv
		stat_tracker = StatTracker.from_csv(@locations)

		assert_instance_of StatTracker, stat_tracker
	end 
end