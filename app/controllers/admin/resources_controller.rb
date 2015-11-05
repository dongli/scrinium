class Admin::ResourcesController < Admin::ApplicationController


  def permitted_attributes
    %w(user_id resourceable_id name description file resourceable_type status)
  end
end
