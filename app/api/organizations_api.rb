class OrganizationsAPI < Grape::API
  resource :organizations do
    desc 'List all organizations.'
    get :names do
      Organization.all.map { |o| [ o.id, o.name ] }
    end
  end
end
