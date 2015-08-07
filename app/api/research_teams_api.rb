class ResearchTeamsAPI < Grape::API
  resource :research_teams do
    desc 'List all research_teams.'
    get :names do
      ResearchTeam.all.map { |t| [ t.id, t.name ] }
    end

    desc 'List all resaerch teams of an organization.'
    params do
      requires :organization_id, type: Integer, desc: 'Organization ID.'
    end
    post :of_organization do
      o = Organization.find_by_id(params[:organization_id])
      return [] if not o
      o.research_teams.map { |t| [ t.id, t.name ] }
    end
  end
end
