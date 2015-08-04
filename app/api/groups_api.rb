class GroupsAPI < Grape::API
  resource :groups do
    desc 'List all groups.'
    get :names do
      Group.all.map { |g| [ g.id, g.name ] }
    end
  end
end
