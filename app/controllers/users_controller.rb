class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :show_home_page]
  before_action :set_user, except: [:index]
  layout :choose_layout

  def index
    @search = User.ransack(params[:q])
    @users = @search.result.order(:id).page(params[:page])
  end

  def show
    if not current_user or current_user != @user
      redirect_to show_user_home_page_path(@user)
    else
      @category = params[:category] || 'articles'
      eval "@#{@category} = @user.#{@category}.order('id DESC').page(params[:page])"
    end
  end

  def show_home_page
  end

  def edit
    @category = params[:category]
  end

  def update
    if params[:user][:profile_attributes].present? and params[:user][:profile_attributes][:crop_x].present?
      @user.profile.crop_x = params[:user][:profile_attributes][:crop_x]
      @user.profile.crop_y = params[:user][:profile_attributes][:crop_y]
      @user.profile.crop_w = params[:user][:profile_attributes][:crop_w]
      @user.profile.crop_h = params[:user][:profile_attributes][:crop_h]
    end
    @category = params[:user][:category]
    @user.update(user_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to session[:previous_url].last, notice: t('message.destroy_success', thing: t('activerecord.models.user')) }
    end
  end

  private

  def choose_layout
    params[:action] == 'show_home_page' ? 'slim_page' : 'application'
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:name, :mobile, :slug,
                                 profile_attributes: [
                                   :id,
                                   :avatar,
                                   :crop_x,
                                   :crop_y,
                                   :crop_w,
                                   :crop_h,
                                   :gender,
                                   :title,
                                   :affiliation,
                                   :country,
                                   :signature,
                                   :bio
                                 ],
                                 experience_attributes: [
                                   :id,
                                   :content
                                 ],
                                 achievement_attributes: [
                                   :id,
                                   :content
                                 ],
                                 user_option_attributes: [
                                   :id,
                                   :front_cover
                                 ],
                                 group_ids: [])
  end
end
