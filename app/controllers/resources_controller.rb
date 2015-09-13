class ResourcesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.all
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
  end

  # GET /resources/new
  def new
    @resource = Resource.new
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(resource_params)

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
