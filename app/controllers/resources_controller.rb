class ResourcesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_app_and_resourceable
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
    @resources = @resourceable.resources
  end

  def show
  end

  def new
    @resource = @resourceable.resources.new
  end

  def edit
  end

  def create
    @resource = @resourceable.resources.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html {
          redirect_to [ @app, @resourceable, @resource ],
          notice: t('message.create_success', thing: t('activerecord.models.resource'))
        }
        format.json {
          render json: { message: 'success', id: @resource.id }, status: 200
        }
      else
        format.html { render :new }
        format.json {
          render json: { error: @resource.errors.full_messages.join(',') }, status: 400
        }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html {
          redirect_to [ @app, @resourceable, @resource ],
          notice: t('message.update_success', thing: t('activerecord.models.resource'))
        }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @resource.destroy
    respond_to do |format|
      session[:previous_url].pop while session[:previous_url].last =~ /resources\/(\d+|new)/
      format.html { redirect_to session[:previous_url].last || root_path, notice: t('message.destroy_success', thing: t('activerecord.models.resource')) }
    end
  end

  private

  def load_app_and_resourceable
    # [/<engine prefix>]/<resourceable_type>/:id/resources/...
    tokens = request.path.split('/').reject(&:empty?)
    n = tokens.index('resources')
    if n == 0
      set_resource
      @resourceable = @resource.resourceable
      tmp = @resourceable.class.to_s.split('::')
      if tmp.size == 1
        @app = main_app
      elsif tmp.size == 2
        @app = eval(tmp.first.underscore)
      end
    else
      resourceable_type, resourceable_id = tokens[n-2..n-1]
      if RailsEnginesHelper.engine_names.index { |x| x =~ /_#{tokens.first}$/ }
        app_name = Rails.app_class.to_s.split('::').first
        resourceable_type = app_name+tokens.first.capitalize+'::'+resourceable_type.singularize.classify
        @app = eval("#{app_name.downcase}_#{tokens.first}")
      else
        resourceable_type = resourceable_type.singularize.classify
        @app = main_app
      end
      @resourceable = resourceable_type.constantize.find(resourceable_id)
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = Resource.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def resource_params
    params.require(:resource).permit(:name,
                                     :description,
                                     :file,
                                     :user_id,
                                     :tag_list,
                                     { category_list: [] },
                                     :status)
  end
end
