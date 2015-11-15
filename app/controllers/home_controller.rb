class HomeController < ApplicationController
  before_action :subdomian_organization

  def index
  end

  def subdomian_organization
    subdomain = request.subdomain
    if subdomain.present? and @organization = Organization.find_by(subdomain: subdomain)
      render "organizations/show"
    end
  end
end
