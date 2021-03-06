class ResourcesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_resourceable, only: [ :new, :create ]
  before_action :set_resource, only: [ :show, :edit, :update, :destroy ]

  def new
    @resource = @resourceable.resources.new
    @resource.folder_id = params[:folder_id]
    @resource.resourceable_type = params[:resourceable_type]
    @resource.resourceable_id = params[:resourceable_id]
  end

  def show
  end

  def edit
  end

  def create
    @resource = @resourceable.resources.new(resource_params)
    @resource.user_id = current_user.id
    authorize @resource, :create? # TODO: 现在还不能抛出资源配额已满的错误提示。
    @resource.name = @resource.file.file.filename if @resource.file.file
    @resource.save
    respond_to do |format|
      format.js
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
      format.html { redirect_to current_user }
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
    elsif params[:resource][:resourceable_id].present? and params[:resource][:resourceable_type].present?
      resourceable_id = params[:resource][:resourceable_id]
      resourceable_type = params[:resource][:resourceable_type]
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
                                     :resourceable_type,
                                     :resourceable_id,
                                     :file,
                                     :tag_list,
                                     { category_list: [] },
                                     :status)
  end
end
