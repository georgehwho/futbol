require 'simplecov'
SimpleCov.start do
end

require 'minitest/pride'
require 'minitest/autorun'
require 'mocha/minitest'

require './lib/stat_tracker'

require './lib/team'
require "./lib/game"
require "./lib/game_team"

require "./lib/game_stats"
require './lib/team_stats'
require "./lib/game_team_stats"
