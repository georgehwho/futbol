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

  def average_goals(gt)
    (gt.sum(&:goals) / gt.size.to_f).round(2)
  end

  def average_win_percentage(id)
  (number_of_wins(id) /array_by_team_id(id).size.to_f).round(2)
  end

  def highest_scoring_visitor
    away_gt = game_teams.find_all { |gt| gt.hoa == 'away'}
    gt_hash = group_game_teams_by_team_id(away_gt)

    hash_average_goals = {}
    gt_hash.each do |t_id, gt|
      hash_average_goals[t_id] = average_goals(gt)
    end

    highest_average_goal_team_id = hash_average_goals.max_by { |k,v| v }[0]
    stat_tracker.team_stats.find_by_id(highest_average_goal_team_id).team_name
  end

  def highest_scoring_home_team
    home_gt = game_teams.find_all { |gt| gt.hoa == 'home'}
    gt_hash = group_game_teams_by_team_id(home_gt)

    hash_average_goals = {}
    gt_hash.each do |t_id, gt|
      hash_average_goals[t_id] = average_goals(gt)
    end

    highest_average_goal_team_id = hash_average_goals.max_by { |k,v| v }[0]
    stat_tracker.team_stats.find_by_id(highest_average_goal_team_id).team_name
  end

  def lowest_scoring_visitor
    away_gt = game_teams.find_all { |gt| gt.hoa == 'away'}
    gt_hash = group_game_teams_by_team_id(away_gt)

    hash_average_goals = {}
    gt_hash.each do |t_id, gt|
      hash_average_goals[t_id] = average_goals(gt)
    end

    lowest_average_goal_team_id = hash_average_goals.min_by { |k,v| v }[0]
    stat_tracker.team_stats.find_by_id(lowest_average_goal_team_id).team_name
  end

  def lowest_scoring_home_team
    home_gt = game_teams.find_all { |gt| gt.hoa == 'home'}
    gt_hash = group_game_teams_by_team_id(home_gt)

    hash_average_goals = {}
    gt_hash.each do |t_id, gt|
      hash_average_goals[t_id] = average_goals(gt)
    end

    lowest_average_goal_team_id = hash_average_goals.min_by { |k,v| v }[0]
    stat_tracker.team_stats.find_by_id(lowest_average_goal_team_id).team_name
  end

  def group_game_teams_by_head_coach(list_of_game_teams = game_teams)
    list_of_game_teams.group_by(&:head_coach)
  end

  def find_head_coach_win_percentage(list_of_game_teams = game_teams, id)
    group_by_head_coach = group_game_teams_by_head_coach(list_of_game_teams)
    wins = group_by_head_coach[id].count { |game_team| game_team.result == "WIN" }
    (wins / group_by_head_coach[id].length.to_f).round(2)
  end

  def winningest_coach(season)
    games_in_a_season = stat_tracker.game_stats.game_ids_by_season(season)

    game_teams_in_a_season = game_teams.find_all do |game_team|
      games_in_a_season.include?(game_team.game_id)
    end

    hash_game_teams_in_season = group_game_teams_by_head_coach(game_teams_in_a_season)

    head_coach_wins = {}
    hash_game_teams_in_season.each do |head_coach, list_of_game_teams|
      head_coach_wins[head_coach] = find_head_coach_win_percentage(list_of_game_teams, head_coach)
    end

    head_coach_wins.max_by { |key,value| value }[0]
  end

  def worst_coach(season)
    games_in_a_season = stat_tracker.game_stats.game_ids_by_season(season)

    game_teams_in_a_season = game_teams.find_all do |game_team|
      games_in_a_season.include?(game_team.game_id)
    end

    hash_game_teams_in_season = group_game_teams_by_head_coach(game_teams_in_a_season)
    head_coach_wins = {}
    hash_game_teams_in_season.each do |head_coach, list_of_game_teams|
      head_coach_wins[head_coach] = find_head_coach_win_percentage(list_of_game_teams, head_coach)
    end

    head_coach_wins.min_by { |key,value| value }[0]
  end

  def group_game_teams_by_team_id(list_of_game_teams = game_teams)
    list_of_game_teams.group_by(&:team_id)
  end

  def tackles_by_team(list_of_game_teams)
    list_of_game_teams.sum do |game_team|
      game_team.tackles
    end
  end

  def most_tackles(season)
    games_in_a_season = stat_tracker.game_stats.game_ids_by_season(season)

    game_teams_in_a_season = game_teams.find_all do |game_team|
    games_in_a_season.include?(game_team.game_id)
    end

    hash_game_teams_in_season = group_game_teams_by_team_id(game_teams_in_a_season)

    total_tackles = {}
    hash_game_teams_in_season.each do |team_id, game_teams|
      total_tackles[team_id] = tackles_by_team(hash_game_teams_in_season[team_id])
    end
    most_tackles_team_id = total_tackles.max_by { |k,v| v }[0]
    stat_tracker.team_stats.find_by_id(most_tackles_team_id).team_name
  end

  def fewest_tackles(season)
    games_in_a_season = stat_tracker.game_stats.game_ids_by_season(season)

    game_teams_in_a_season = game_teams.find_all do |game_team|
    games_in_a_season.include?(game_team.game_id)
    end

    hash_game_teams_in_season = group_game_teams_by_team_id(game_teams_in_a_season)

    total_tackles = {}
    hash_game_teams_in_season.each do |team_id, game_teams|
    total_tackles[team_id] = tackles_by_team(hash_game_teams_in_season[team_id])
    end
    most_tackles_team_id = total_tackles.min_by { |k,v| v }[0]
    stat_tracker.team_stats.find_by_id(most_tackles_team_id).team_name
  end

  def accuracy_of_game_teams(list_of_game_teams)
    list_of_game_teams.sum(&:goals).to_f/list_of_game_teams.sum(&:shots)
  end

  def most_accurate_team(season)
    games_in_a_season = stat_tracker.game_stats.game_ids_by_season(season)

    game_teams_in_a_season = game_teams.find_all do |game_team|
    games_in_a_season.include?(game_team.game_id)
    end

    hash_game_teams_in_season = group_game_teams_by_team_id(game_teams_in_a_season)

    team_accuracy = {}
    hash_game_teams_in_season.each do |team_id, game_teams|
    team_accuracy[team_id] = accuracy_of_game_teams(hash_game_teams_in_season[team_id])
    end

    most_accurate_team_id = team_accuracy.max_by { |k,v| v }[0]
    stat_tracker.team_stats.find_by_id(most_accurate_team_id).team_name
  end

  def least_accurate_team(season)
    games_in_a_season = stat_tracker.game_stats.game_ids_by_season(season)

    game_teams_in_a_season = game_teams.find_all do |game_team|
    games_in_a_season.include?(game_team.game_id)
    end

    hash_game_teams_in_season = group_game_teams_by_team_id(game_teams_in_a_season)

    team_accuracy = {}
    hash_game_teams_in_season.each do |team_id, game_teams|
    team_accuracy[team_id] = accuracy_of_game_teams(hash_game_teams_in_season[team_id])
    end

    least_accurate_team_id = team_accuracy.min_by { |k,v| v }[0]
    stat_tracker.team_stats.find_by_id(least_accurate_team_id).team_name
  end

  def favorite_opponent(id)
    hash_of_game_teams_by_team_id = group_game_teams_by_team_id
    game_teams_for_team = hash_of_game_teams_by_team_id[id]

    opponents = {}
    game_teams.each do |og_game_team|
      game_teams_for_team.each do |team_game_team|
        opponents[og_game_team.team_id] = [] if opponents[og_game_team.team_id].nil?
        opponents[og_game_team.team_id] << og_game_team if og_game_team.game_id == team_game_team.game_id && og_game_team.team_id != team_game_team.team_id
      end
    end
    opponents.delete_if { |k,v| v.empty? }

    opponents_win_percentage = {}
    opponents.each do |team_id, list_of_game_teams|
      opponents_win_percentage[team_id] = find_team_win_percentage(list_of_game_teams, team_id)
    end
    fav_opp_team_id = opponents_win_percentage.min_by { |h,v| v }[0]
    stat_tracker.team_stats.find_by_id(fav_opp_team_id).team_name
  end

  def rival(id)
    hash_of_game_teams_by_team_id = group_game_teams_by_team_id
    game_teams_for_team = hash_of_game_teams_by_team_id[id]

    opponents = {}
    game_teams.each do |og_game_team|
      game_teams_for_team.each do |team_game_team|
        opponents[og_game_team.team_id] = [] if opponents[og_game_team.team_id].nil?
        opponents[og_game_team.team_id] << og_game_team if og_game_team.game_id == team_game_team.game_id && og_game_team.team_id != team_game_team.team_id
      end
    end
    opponents.delete_if { |k,v| v.empty? }

    opponents_win_percentage = {}
    opponents.each do |team_id, list_of_game_teams|
      opponents_win_percentage[team_id] = find_team_win_percentage(list_of_game_teams, team_id)
    end
    fav_opp_team_id = opponents_win_percentage.max_by { |h,v| v }[0]
    stat_tracker.team_stats.find_by_id(fav_opp_team_id).team_name
  end

  def find_team_win_percentage(list_of_game_teams = game_teams, id)
    group_by_teams = group_game_teams_by_team_id(list_of_game_teams)
    wins = group_by_teams[id].count { |game_team| game_team.result == "WIN" }
    (wins / group_by_teams[id].length.to_f)
  end
end
