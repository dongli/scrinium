module V1
  class UsersAPI < ApiBase #Grape::API

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

      desc 'get all users'
      params do
        optional :page, type: Integer, desc: 'page'
        optional :per_page, type: Integer, desc: 'per_page'
      end

      # get do
      #   authenticate! # 可进行用户是否登录验证
      #   @users = User.includes(:profile).all.page(params[:page] || 1).per(params[:per_page] || 1)#.includes(:profile)
      #   paginate(@users)
      #
      # end

      desc 'get one user info'
      params do
        requires :id, type: String, desc: 'user id.'
      end

      get ':id' do
        @user = User.includes(:profile).find(params[:id])
        error!( "user unauthorized for this" ) unless UserPolicy.new(current_user, @user).update?
        @user
      end

      desc 'update one user info'
      params do
        requires :id, type: String, desc: 'user id.'
        optional :name, type: String, desc: 'user name.'
      end

      put ':id' do
        @user = User.find(params[:id])
        error!("user unauthorized for this" ) unless UserPolicy.new(current_user, @user).update?
        @user.update(name: params[:name])
        @user
      end

      desc 'search users by name or email'
      params do
        optional :q, type: String, desc: 'search user_name or user_email'
      end

      get do
        # authenticate!
        @users = User.search(params[:q], options= {}).records.includes(:profile).page(params[:page]).per(2)
      end


    end
  end
end
