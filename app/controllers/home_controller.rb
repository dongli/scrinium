class HomeController < ApplicationController
  layout 'home_page'
  before_action :dispatch_subdomain

  def index
    redirect_to current_user if user_signed_in?
  end

  def about
  end

  protected

  def dispatch_subdomain
    if current_tenant
      tenant_type = current_tenant.class.name.downcase
      eval "@#{tenant_type} = current_tenant"
      render "#{tenant_type.pluralize}/show", layout: 'application'
    end
  end
end
