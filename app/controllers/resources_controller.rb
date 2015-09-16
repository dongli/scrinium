class ResourcesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_user_and_resourceable
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  # GET /resources
  # GET /resources.json
  def index
    @resources = @resourceable.resources
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
  end

  # GET /resources/new
  def new
    @resource = @resourceable.resources.new
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = @resourceable.resources.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html {
          redirect_to ResourcesHelper.filter_user([ @app, current_user, @resourceable, @resource ]),
          notice: t('message.create_success', thing: t('scrinium.resource'))
        }
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
        format.html {
          redirect_to ResourcesHelper.filter_user([ @app, current_user, @resourceable, @resource ]),
          notice: t('message.update_success', thing: t('scrinium.resource'))
        }
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
      session[:previous_url].pop while session[:previous_url].last =~ /resources\/(\d+|new)/
      format.html { redirect_to session[:previous_url].last || root_path, notice: t('message.destroy_success', thing: t('scrinium.resource')) }
    end
  end

  private

  def load_user_and_resourceable
    # [/<engine prefix>]/users/:id[/<other prefices>]*/<resourceable_type>/:id/resources/...
    tokens = request.path.split('/').reject(&:empty?)
    @user = User.find(tokens[tokens.index('users')+1])
    n = tokens.index('resources')
    resourceable_type, resourceable_id = tokens[n-2..n-1]
    if tokens.first == 'users'
      resourceable_type = resourceable_type.singularize.classify
      @app = main_app
    else
      app_name = Rails.app_class.to_s.split('::').first
      resourceable_type = app_name+tokens.first.capitalize+'::'+resourceable_type.singularize.classify
      @app = eval("#{app_name.downcase}_#{tokens.first}")
    end
    @resourceable = resourceable_type.constantize.find(resourceable_id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = Resource.find(params[:id])
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
