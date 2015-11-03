class Admin::ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  inherit_resources

  layout "admin"

  before_action :authenticate_user!, except: [:logout]


  def index
    @q = resource_class.search(params[:q])
  end

  def create
    create! do |success, failure|
      success.html do
        flash[:notice] = t('message.create_success', thing: thing)
        redirect_to(resource_url)
      end

      failure.html do
        flash[:error] =  t('message.create_fail', thing: thing)
        render :action => :new
      end
    end
  end


  def update
    update! do |success, failure|
      success.html do
        flash[:notice] = t('message.update_success', thing: thing)
        redirect_to(resource_url)
      end

      failure.html do
        flash[:error] = t('message.update_fail', thing: thing)
        render :action => :edit
      end
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html do
        flash[:notice] = t('message.destroy_success', thing: thing)
        redirect_to(resource_url)
      end

      failure.html do
        flash[:error] = t('message.destroy_fail', thing: thing)
        render :action => :edit
      end
    end
  end

  helper_method :attributes, :permitted_attributes
  respond_to :js, :json, :html

  protected

  def collection
    get_collection_ivar || set_collection_ivar(end_of_association_chain.
                                                   search(params[:q]).result.page(params[:page] || 1).per(params[:per_page]))
  end

  def permitted_params
    params_keys = (resource_class.attribute_names - %w(id created_at updated_at )).map(&:to_sym)
    params.permit(resource_class.to_s.downcase.to_sym => params_keys)
  end

  def permitted_attributes
    resource_class.attribute_names - %w(id created_at updated_at )
  end

  def attributes
    resource_class.attribute_names - %w(id created_at updated_at )
  end

  def thing
    t("activerecord.models.#{resource_class.to_s.underscore}")
  end


end
