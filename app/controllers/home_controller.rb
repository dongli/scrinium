class HomeController < ApplicationController
  layout :choose_layout
  before_action :subdomian_organization

  def index
  end

  def old_index
  end

  def subdomian_organization
    subdomain = request.subdomain
    if subdomain.present? and @organization = Organization.find_by(subdomain: subdomain)
      render "organizations/show"
    end
  end

  def choose_layout
    params[:old].present? ? "application" : "home_page"
  end
end
