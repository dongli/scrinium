class UsersAPI < Grape::API
  resource :users do
    desc 'List all users.'
    get :full_names do
      User.all.map { |u| [ u.id, u.full_name ] }
    end
  end
end