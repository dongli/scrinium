class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_user, only: [ :show, :edit, :update, :destroy, :change_current_organization ]

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
        format.html { redirect_to session[:previous_url].last, notice: t('message.update_success', thing: t('activerecord.models.user')) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to session[:previous_url].last, notice: t('message.destroy_success', thing: t('activerecord.models.user')) }
    end
  end

  def change_current_organization
    @user.current_organization_id = params[:organization_id]
    respond_to do |format|
      if @user.save!
        format.html { redirect_to :root }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :mobile,
                                 profile_attributes: [
                                   :avatar,
                                   :string,
                                   :gender,
                                   :string,
                                   :title,
                                   :city,
                                   :country,
                                   :qq,
                                   :weibo,
                                   :wechat
                                 ],
                                 publication_ids: [],
                                 group_ids: [])
  end
end
