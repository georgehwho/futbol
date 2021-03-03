require_relative 'game_team'
require_relative 'load_csv'
require_relative 'math'

class GameTeamStats
  include LoadCSV
  include Math

  attr_reader :game_teams,
              :stat_tracker,
              :team_id_hash,
              :hoa_hash

  def initialize(file_path, stat_tracker)
    @stat_tracker = stat_tracker
    @game_teams   = []
    create_game_teams_array(file_path)
    @team_id_hash = group_by_team_id
    @hoa_hash = group_by_hoa
  end

  def create_game_teams_array(file_path)
    @game_teams = load_csv(file_path, GameTeam)
  end

  def group_by_team_id(list_of_game_teams = game_teams)
    list_of_game_teams.group_by { |team| team.team_id }
  end

  ### team stats ###

  def average_win_percentage(id, hash = team_id_hash)
    all_wins = hash[id].count { |game_team| game_team.result == 'WIN' }
    percentage(all_wins, hash[id].size)
  end

  def most_goals_scored(id)
    team_id_hash[id].max_by(&:goals).goals
  end

  def fewest_goals_scored(id)
    team_id_hash[id].min_by(&:goals).goals
  end

  # def best_season(id)
  #   stat_tracker.game_stats.game_ids_by_season
  # end

  ### league stats ###
  def count_of_teams
    game_teams.uniq(&:team_id).size
  end

  def average_goals_of_game_team(list_of_game_teams)
    all_goals = list_of_game_teams.sum(&:goals)
    percentage(all_goals, list_of_game_teams.size)
  end

  def best_offense
    team_with_best_offense = team_id_hash.max_by do |team_id, game_team|
      average_goals_of_game_team(game_team)
    end
    best_offense_team_id = team_with_best_offense[0]
    stat_tracker.find_team_name_by_id(best_offense_team_id)
  end

  def worst_offense
    team_with_worst_offense = team_id_hash.min_by do |team_id, game_team|
      average_goals_of_game_team(game_team)
    end
    worst_offense_team_id = team_with_worst_offense[0]
    stat_tracker.find_team_name_by_id(worst_offense_team_id)
  end

  #################################
  def average_goals(game_team)
    percentage(game_team.sum(&:goals), game_team.size)
  end

  def group_by_hoa
    game_teams.group_by(&:hoa)
  end

  def convert_to_average_goals(game_team_hash)
    game_team_hash.map do |team_id, game_team|
      game_team_hash[team_id] = average_goals(game_team)
    end
  end

  def highest_team_id(hash)
    hash.max_by { |k,v| v }[0]
  end

  def lowest_team_id(hash)
    hash.min_by { |k,v| v }[0]
  end

  def highest_scoring_visitor
    away_team_hash = group_by_team_id(hoa_hash['away'])
    convert_to_average_goals(away_team_hash)
    team_id = highest_team_id(away_team_hash)
    stat_tracker.find_team_name_by_id(team_id)
  end

  def highest_scoring_home_team
    home_team_hash = group_by_team_id(hoa_hash['home'])
    convert_to_average_goals(home_team_hash)
    team_id = highest_team_id(home_team_hash)
    stat_tracker.find_team_name_by_id(team_id)
  end

  def lowest_scoring_visitor
    away_team_hash = group_by_team_id(hoa_hash['away'])
    convert_to_average_goals(away_team_hash)
    team_id = lowest_team_id(away_team_hash)
    stat_tracker.find_team_name_by_id(team_id)
  end

  def lowest_scoring_home_team
    home_team_hash = group_by_team_id(hoa_hash['home'])
    convert_to_average_goals(home_team_hash)
    team_id = lowest_team_id(home_team_hash)
    stat_tracker.find_team_name_by_id(team_id)
  end

  ### end of league stats ###


  ######################
  def group_by_head_coach(list_of_game_teams = game_teams)
    list_of_game_teams.group_by(&:head_coach)
  end

  def convert_to_win_percentage(game_team_hash)
    game_team_hash.map do |id, game_team|
      game_team_hash[id] = average_win_percentage(id, game_team_hash)
    end
  end

  def game_teams_in_a_season(season)
    game_ids_in_a_season = stat_tracker.game_ids_by_season(season)
    game_teams_in_a_season = game_teams.find_all do |game_team|
      game_ids_in_a_season.include?(game_team.game_id)
    end
  end

  def winningest_coach(season)
    hash_game_teams = group_by_head_coach(game_teams_in_a_season(season))
    convert_to_win_percentage(hash_game_teams)
    highest_team_id(hash_game_teams)
  end

  def worst_coach(season)
    hash_game_teams = group_by_head_coach(game_teams_in_a_season(season))
    convert_to_win_percentage(hash_game_teams)
    lowest_team_id(hash_game_teams)
  end

########

  def tackles_by_team(list_of_game_teams)
    list_of_game_teams.sum(&:tackles)
  end

  def convert_to_tackles(game_team_hash)
    game_team_hash.map do |team_id, game_team|
      game_team_hash[team_id] = tackles_by_team(game_team)
    end
  end

  def most_tackles(season)
    hash_game_teams = group_by_team_id(game_teams_in_a_season(season))
    convert_to_tackles(hash_game_teams)
    tackles_team_id = highest_team_id(hash_game_teams)
    stat_tracker.find_team_name_by_id(tackles_team_id)
  end

  def fewest_tackles(season)
    hash_game_teams = group_by_team_id(game_teams_in_a_season(season))
    convert_to_tackles(hash_game_teams)
    tackles_team_id = lowest_team_id(hash_game_teams)
    stat_tracker.find_team_name_by_id(tackles_team_id)
  end

  #####

  def accuracy_of_game_teams(list_of_game_teams)
    percentage(list_of_game_teams.sum(&:goals), list_of_game_teams.sum(&:shots), 5)
  end

  def convert_to_accuracy(game_team_hash)
    game_team_hash.map do |team_id, game_team|
      game_team_hash[team_id] = accuracy_of_game_teams(game_team)
    end
  end

  def most_accurate_team(season)
    hash_game_teams = group_by_team_id(game_teams_in_a_season(season))
    convert_to_accuracy(hash_game_teams)
    accuracy_team_id = highest_team_id(hash_game_teams)
    stat_tracker.find_team_name_by_id(accuracy_team_id)
  end

  def least_accurate_team(season)
    hash_game_teams = group_by_team_id(game_teams_in_a_season(season))
    convert_to_accuracy(hash_game_teams)
    accuracy_team_id = lowest_team_id(hash_game_teams)
    stat_tracker.find_team_name_by_id(accuracy_team_id)
  end

  #####

  def find_all_opponents(id)
    game_ids_for_game_team = team_id_hash[id].map(&:game_id)

    opponent_team_ids = stat_tracker.game_stats.opponent_team_ids(id)

    opponent_game_teams = opponent_team_ids.flat_map do |team_id|
      team_id = team_id_hash[team_id]
    end.compact

    cleaned_game_teams = opponent_game_teams.delete_if do |game_team|
      not game_ids_for_game_team.include?(game_team.game_id)
    end

    opponents = opponent_game_teams.group_by do |team|
      team.team_id
    end
  end

  def favorite_opponent(id)
    opponents = find_all_opponents(id)
    convert_to_win_percentage(opponents)
    fav_opp_team_id = lowest_team_id(opponents)
    stat_tracker.find_team_name_by_id(fav_opp_team_id)
  end

  def rival(id)
    opponents = find_all_opponents(id)
    convert_to_win_percentage(opponents)
    fav_opp_team_id = highest_team_id(opponents)
    stat_tracker.find_team_name_by_id(fav_opp_team_id)
  end
end
