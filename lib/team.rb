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
    @teamName     = data[:teamName]
    @abbreviation = data[:abbreviation]
    @stadium      = data[:stadium]
    @link         = data[:link]
  end
end
