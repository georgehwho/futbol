class Team
  attr_reader :team_id,
              :franchiseId,
              :teamName,
              :abbreviation,
              :stadium,
              :link

  def initialize(data)
    @team_id      = data[:team_id].to_i
    @franchiseId  = data[:franchiseId].to_i
    @teamName     = data[:teamName].to_s
    @abbreviation = data[:abbreviation].to_s
    @stadium      = data[:stadium].to_s
    @link         = data[:link].to_s
  end
end
