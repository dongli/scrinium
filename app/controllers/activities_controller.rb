class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order('created_at desc').where(owner_id: current_user.following_ids, owner_type: 'User').page(params[:page])
  end
end
