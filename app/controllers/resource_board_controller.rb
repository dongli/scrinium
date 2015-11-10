class ResourceBoardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_owner

  def index
    @current_folder = @owner.folders.first
  end

  private

  def set_owner
    if params[:owner_id].present? and params[:owner_type].present?
      @owner = params[:owner_type].classify.constantize.find(params[:owner_id])
    else
      @owner = current_user
    end
  end
end
