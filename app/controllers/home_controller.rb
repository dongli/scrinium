class HomeController < ApplicationController
  layout 'home_page'
  before_action :subdomian_organization

  def index
    redirect_to current_user if user_signed_in?
  end

  def about
  end

  def subdomian_organization
    subdomain = request.subdomain
    if subdomain.present? and @organization = Organization.find_by(subdomain: subdomain)
      render "organizations/show", layout: 'application'
    end
  end
end
