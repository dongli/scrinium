class UserOptionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user_option, only: [:show, :edit, :update, :destroy]

  def index
    @user_options = UserOption.all
  end

  def show
  end

  def new
    @user_option = UserOption.new
  end

  def edit
  end

  def create
    @user_option = UserOption.new(user_option_params)

    respond_to do |format|
      if @user_option.save
        format.html { redirect_to @user_option, notice: 'User option was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user_option.update(user_option_params)
        format.html { redirect_to @user_option, notice: 'User option was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user_option.destroy
    respond_to do |format|
      format.html { redirect_to user_options_url, notice: 'User option was successfully destroyed.' }
    end
  end

  private

  def set_user_option
    @user_option = UserOption.find(params[:id])
  end

  def user_option_params
    params.require(:user_option).permit(:user_id, :front_cover)
  end
end
