class UsersAPI < Grape::API
  resource :users do
    desc 'List all users.'
    get :names do
      User.all.map { |u| [ u.id, u.name ] }
    end
  end
end