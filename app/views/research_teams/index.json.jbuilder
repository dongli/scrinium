json.array!(@research_teams) do |research_team|
  json.extract! research_team, :id
  json.url research_team_url(research_team, format: :json)
end
