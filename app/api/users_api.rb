class UsersAPI < Grape::API
  resource :users do
    desc 'List all users.'
    get :names do
      User.all.map { |u| [ u.id, u.name ] }
    end

    desc 'Get user avatar'
    params do
      requires :user_id, type: Integer, desc: 'User ID.'
      optional :size, type: String, desc: 'Avatar image size.'
    end
    post :avatar do
      user = User.find_by_id(params[:user_id])
      user.avatar.url(params[:size])
    end
  end
end
