class FoldersController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_folderable
  before_action :set_folder, only: [ :show, :edit, :update, :destroy ]

  def new
    @folder = @folderable.folders.new
    @folder.parent_id = params[:folder_id]
  end

  def show
  end

  def edit
  end

  def create
    @folder = @folderable.folders.new(folder_params)
    respond_to do |format|
      if @folder.save! # TODO: 处理错误。
        format.js
      end
    end
  end

  def update
    if params[:parent_id].present?
      @update_action = :move
    elsif params[:folder][:name].present?
      @update_action = :rename
    end
    respond_to do |format|
      if @folder.update!(folder_params) # TODO: 处理错误。
        format.js
      end
    end
  end

  def destroy
    @folder.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def set_folderable
    if params[:folderable_id].present? and params[:folderable_type].present?
      folderable_id = params[:folderable_id]
      folderable_type = params[:folderable_type]
    else
      folderable_id = current_user.id
      folderable_type = 'User'
    end
    @folderable = folderable_type.classify.constantize.find(folderable_id)
  end

  def folder_params
    # TODO: 我不知道如何直接在a中的href里写嵌套参数。
    params[:folder] ||= {}
    params.each do |key, value|
      params[:folder][key] = value
    end
    params.require(:folder).permit(:user_id,
                                   :name,
                                   :description,
                                   :item_count,
                                   :parent_id,
                                   :folderable_id,
                                   :folderable_type,
                                   :status,
                                   :position)
  end
end
