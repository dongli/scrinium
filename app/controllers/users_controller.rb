class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: t('user.destroy_success') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:full_name,
                                 :gender,
                                 :organization_id,
                                 :research_team_id,
                                 { group_ids: [] },
                                 :position,
                                 :email,
                                 :role)
  end
end
