class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  def show
  end

  def edit
  end

  def update
    if params[:user][:profile_attributes][:crop_x].present?
      @user.profile.crop_x = params[:user][:profile_attributes][:crop_x]
      @user.profile.crop_y = params[:user][:profile_attributes][:crop_y]
      @user.profile.crop_w = params[:user][:profile_attributes][:crop_w]
      @user.profile.crop_h = params[:user][:profile_attributes][:crop_h]
    end
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

  def change_password
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update(password_params)
      redirect_to root_path
    else
      redirect_to "users/change_password"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:name, :mobile,
                                 profile_attributes: [
                                   :avatar,
                                   :crop_x,
                                   :crop_y,
                                   :crop_w,
                                   :crop_h,
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
                                 group_ids: [])
  end
end
