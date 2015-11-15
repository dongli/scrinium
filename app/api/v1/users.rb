module V1
  class Users < ApiBase #Grape::API

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

      get do
        authenticate! # 可进行用户是否登录验证
        @users = User.includes(:profile).all.page(params[:page] || 1).per(params[:per_page] || 1)#.includes(:profile)
        paginate(@users)

        # @profile = current_user.profile
      end

      get ':id' do
        @user = User.includes(:profile).find(params[:id])
      end
    end
  end
end
