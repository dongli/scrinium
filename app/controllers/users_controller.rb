class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to session[:previous_url], notice: t('message.update_success', thing: t('scrinium.user')) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to session[:previous_url], notice: t('message.destroy_success', thing: t('scrinium.user')) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    ApplicationHelper.transform_params params, :user, [:gender, :role, :position]
    params.require(:user).permit(:avatar,
                                 :name,
                                 :gender,
                                 :organization_id,
                                 :research_team_id,
                                 { group_ids: [] },
                                 :position,
                                 :email,
                                 :role,
                                 :password,
                                 :password_confirmation)
  end
end
