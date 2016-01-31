class Api::V1::UsersController < Api::ApplicationController
  def index
    @users = User.ransack(params[:q]).result
    render json: @users
  end
end
