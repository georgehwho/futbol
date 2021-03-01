require_relative 'game_team'
require_relative 'load_csv'

class GameTeamStats
  include LoadCSV

  attr_reader :game_teams,
  :stat_tracker,
  :game_teams_hash

  def initialize(file_path, stat_tracker)
    @stat_tracker = stat_tracker
    @game_teams   = []
    create_game_teams_array(file_path)
    @game_teams_hash = group_game_teams_by_team_id
  end

  def create_game_teams_array(file_path)
    @game_teams = load_csv(file_path, GameTeam)
  end

  def count_of_teams
    game_teams.uniq do |team|
      team.team_id
    end.size
  end

  def group_game_teams_by_team_id(list_of_game_teams = game_teams)
    list_of_game_teams.group_by { |team| team.team_id }
  end

  def average_goals_of_game_team(list_of_game_teams = game_teams)
    all_goals = list_of_game_teams.sum(&:goals)
    (all_goals / list_of_game_teams.size.to_f).round(2)
  end

  def best_offense
    team_with_best_offense = group_game_teams_by_team_id.max_by do |team_id, game_team|
      average_goals_of_game_team(game_team)
    end
    best_offense_team_id = team_with_best_offense[0]
    stat_tracker.team_stats.find_by_id(best_offense_team_id).team_name
  end

  def worst_offense
    team_with_worst_offense = group_game_teams_by_team_id.min_by do |team_id, game_team|
      average_goals_of_game_team(game_team)
    end
    worst_offense_team_id = team_with_worst_offense[0]
    stat_tracker.team_stats.find_by_id(worst_offense_team_id).team_name
  end

  def array_by_team_id(id)
    all_games =[]
    @game_teams.each do |game_team|
      if game_team.team_id == id
        all_games << game_team
      end
    end
    all_games
  end

  def number_of_wins(id)
    array_by_team_id(id).find_all do  |game_team|
      game_team.result == "WIN"
    end.size
  end

  def average_win_percentage(id)
    (number_of_wins(id) /array_by_team_id(id).size.to_f).round(2)
  end

  def find_team_win_percentage(list_of_game_teams = game_teams, id)
    group_by_teams = group_game_teams_by_team_id(list_of_game_teams)
    wins = group_by_teams[id].count { |game_team| game_team.result == "WIN" }
    (wins / group_by_teams[id].length.to_f).round(2)
  end

  def winningest_coach(season)
    games_in_a_season = stat_tracker.game_stats.game_ids_by_season(season)

    game_teams_in_a_season = game_teams.find_all do |game_team|
      games_in_a_season.include?(game_team.game_id)
    end

    hash_game_games_in_season = group_game_teams_by_team_id(game_teams_in_a_season)

    team_wins = {}
    hash_game_games_in_season.each do |team_id, list_of_game_teams|
      team_wins[team_id] = find_team_win_percentage(list_of_game_teams, team_id)
    end

    winningest_team_id = team_wins.max_by { |key,value| value }[0]

    hash_game_games_in_season[winningest_team_id][0].head_coach
  end

  def worst_coach(season)
    games_in_a_season = stat_tracker.game_stats.game_ids_by_season(season)

    game_teams_in_a_season = game_teams.find_all do |game_team|
      games_in_a_season.include?(game_team.game_id)
    end

    hash_game_games_in_season = group_game_teams_by_team_id(game_teams_in_a_season)

    team_wins = {}
    hash_game_games_in_season.each do |team_id, list_of_game_teams|
      team_wins[team_id] = find_team_win_percentage(list_of_game_teams, team_id)
    end

    winningest_team_id = team_wins.min_by { |key,value| value }[0]

    hash_game_games_in_season[winningest_team_id]
    require 'pry'; binding.pry
  end
end