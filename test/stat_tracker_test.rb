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

	def test_it_knows_how_to_count_games_by_season
		expected = {
			"20122013"=>49,
			"20142015"=>1
		}
		assert_equal expected, @stat_tracker.count_of_games_by_season
	end

	def test_it_knows_the_average_goals_per_game
		assert_equal 3.9, @stat_tracker.average_goals_per_game
	end

	def test_it_knows_the_average_goals_by_season
		# skip
		expected = {
			"20122013"=>3.92,
			"20142015"=>3.0
		}
		assert_equal expected, @stat_tracker.average_goals_by_season
	end

	def test_it_has_a_best_season
		assert_equal "20122013", @stat_tracker.best_season('19')
	end

	def test_it_has_a_worst_season
		assert_equal  "20122013", @stat_tracker.worst_season('19')
	end


	### Team Stat Test ###
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

	def test_it_has_a_win_average
		assert_equal 0.57, @stat_tracker.average_win_percentage('17')
	end

	def test_most_goals_scored
		assert_equal 4, @stat_tracker.most_goals_scored('19')
	end

	def test_fewest_goals_scored
		assert_equal 0, @stat_tracker.fewest_goals_scored('19')
	end
	### League Stats Test ###
	def test_it_can_count_teams
		assert_equal 9, @stat_tracker.count_of_teams
	end

	def test_it_can_find_the_team_with_the_best_offense
		assert_equal "New York City FC", @stat_tracker.best_offense
	end

	def test_it_can_find_the_team_with_the_worst_offense
		assert_equal "Sporting Kansas City", @stat_tracker.worst_offense
	end

	### Season Stats ###
	def test_winningest_coach
		assert_equal "Claude Julien", @stat_tracker.winningest_coach('20122013')
	end

	def test_worst_coach
    assert_equal "John Tortorella", @stat_tracker.worst_coach('20142015')
  end
end
