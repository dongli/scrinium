class ResourcesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_resourceable
  before_action :set_resource, only: [ :show, :edit, :update, :destroy ]

  def new
    @resource = @resourceable.resources.new
    @resource.folder_id = params[:folder_id]
  end

  def show
  end

  def edit
  end

  def create
    @resource = @resourceable.resources.new(resource_params)
    @resource.name = @resource.file.file.filename
    respond_to do |format|
      if @resource.save! # TODO: 处理错误。
        format.js
      end
    end
  end

  def update
    if params[:folder_id].present?
      @update_action = :move
    elsif params[:resource][:name].present?
      @update_action = :rename
    end
    respond_to do |format|
      if @resource.update!(resource_params)
        format.js
      end
    end
  end

  def destroy
    @resource.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def set_resourceable
    if params[:resourceable_id].present? and params[:resourceable_type].present?
      resourceable_id = params[:resourceable_id]
      resourceable_type = params[:resourceable_type]
    else
      resourceable_id = current_user.id
      resourceable_type = 'User'
    end
    @resourceable = resourceable_type.classify.constantize.find(resourceable_id)
  end

  def resource_params
    # TODO: 我不知道如何直接在a中的href里写嵌套参数。
    params[:resource] ||= {}
    params.each do |key, value|
      params[:resource][key] = value
    end
    params.require(:resource).permit(:name,
                                     :description,
                                     :folder_id,
                                     :file,
                                     :user_id,
                                     :tag_list,
                                     { category_list: [] },
                                     :status)
  end
end
