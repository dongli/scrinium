class ResourcesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_user_and_resourceable
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  # GET /resources
  # GET /resources.json
  def index
    @resources = @resourceable ? @resourceable.resources : Resource.all
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
  end

  # GET /resources/new
  def new
    @resource = @resourceable ? @resourceable.resources.new : Resource.new
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = @resourceable ? @resourceable.resources.new(resource_params) : Resource.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html { redirect_to [ current_user, @resource ], notice: t('message.create_success', thing: t('scrinium.resource')) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /resources/1
  # PATCH/PUT /resources/1.json
  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to [ current_user, @resource ], notice: t('message.update_success', thing: t('scrinium.resource')) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to user_resources_url, notice: t('message.destroy_success', thing: t('scrinium.resource')) }
    end
  end

  private

  def load_user_and_resourceable
    match = request.path.match(/\/users\/(\d+)\/((\w+)\/(\d+))?/)
    user_id = match[1]
    @user = User.find(user_id)
    # NOTE: resource有可能是单独存在的，即不属于任何resourceable。
    if match[2] and match[3] != 'resources'
      resourceable_type = match[3]
      resourceable_id = match[4]
      # NOTE: 这里要求所有engine命名规则为<主应用名><子应用名>，并且挂在路径为'/<子应用名>'。
      engine = request.path.match(/^\/(\w+)/)[1]
      if engine != 'users'
        app_name = Rails.app_class.to_s.split('::').first
        resourceable_type = app_name+engine.capitalize+'::'+resourceable_type.singularize.classify
        @app = eval("#{app_name.downcase}_#{engine}")
      else
        resourceable_type = resourceable_type.singularize.classify
        @app = main_app
      end
      @resourceable = resource_type.constantize.find(resourceable_id)
    else
      @app = main_app
      @resourceable = nil
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = @resourceable ? @resourceable.resources.find(params[:id]) : Resource.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def resource_params
    transform_params params, :resource, [ :resource_type ]
    params.require(:resource).permit(:name,
                                     :resource_type,
                                     :description,
                                     :file,
                                     :user_id,
                                     :tag_list,
                                     { category_list: [] })
  end
end
