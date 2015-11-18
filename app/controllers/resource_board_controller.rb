class ResourceBoardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folderable

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

  def move_files
    @folders = params[:folder_ids].present? ? Folder.find(params[:folder_ids]) : []
    respond_to do |format|
      format.js
    end
  end

  def share_files
    respond_to do |format|
      format.js
    end
  end

  private

  def set_folderable
    if params[:folderable_id].present? and params[:folderable_type].present?
      @folderable = params[:folderable_type].classify.constantize.find(params[:folderable_id])
    else
      @folderable = current_user
    end
  end
end
