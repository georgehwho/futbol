require 'simplecov'
SimpleCov.start do
end

require 'minitest/pride'
require 'minitest/autorun'
require 'mocha/minitest'

require './lib/team'
require "./lib/game"
require "./lib/game_teams"

require "./lib/game_stats"
require './lib/team_stats'
require "./lib/game_teams_stats"
