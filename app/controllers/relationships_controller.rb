class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def follow
    @followed = User.friendly.find(params[:followed_id])
    @relationship = Relationship.new(followed_id: @followed.id, follower_id: current_user.id)
    respond_to do |format|
      if @relationship.save
        format.js
      end
    end
  end

  def unfollow
    @followed = User.friendly.find(params[:followed_id])
    @relationship = Relationship.find_by(followed_id: @followed.id, follower_id: current_user.id)
    @relationship.destroy
    respond_to do |format|
      format.js
    end
  end

  def followers
    @user = User.friendly.find(params[:user_id])
    @followers = @user.followers.page(params[:page])
    respond_to do |format|
      format.html
    end
  end

  def following
    @user = User.friendly.find(params[:user_id])
    @following = @user.following.page(params[:page])
    respond_to do |format|
      format.html
    end
  end
end
