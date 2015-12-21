class GroupOptionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_group_option, only: [:show, :edit, :update, :destroy]

  def index
    @group_options = GroupOption.all
  end

  def show
  end

  def new
    @group_option = GroupOption.new
  end

  def edit
  end

  def create
    @group_option = GroupOption.new(group_option_params)

    respond_to do |format|
      if @group_option.save
        format.html { redirect_to @group_option, notice: 'Group option was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @group_option.update(group_option_params)
        format.html { redirect_to @group_option, notice: 'Group option was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @group_option.destroy
    respond_to do |format|
      format.html { redirect_to group_options_url, notice: 'Group option was successfully destroyed.' }
    end
  end

  private

  def set_group_option
    @group_option = GroupOption.find(params[:id])
  end

  def group_option_params
    params.require(:group_option).permit(:group_id, :front_cover)
  end
end
