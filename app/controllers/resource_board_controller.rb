class ResourceBoardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_owner

  def index
    @current_folder = @owner.folders.first
  end

  def rename_file
    if params[:folder_id].present?
      @folder = Folder.find(params[:folder_id])
    elsif params[:resource_id].present?
      @resource = Resource.find(params[:resource_id])
    end
    respond_to do |format|
      format.js
    end
  end

  def delete_files
    respond_to do |format|
      format.js
    end
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
