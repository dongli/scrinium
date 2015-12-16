class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def follow
    @followed_id = params[:followed_id]
    @relationship = Relationship.new(followed_id: params[:followed_id], follower_id: current_user.id)
    respond_to do |format|
      if @relationship.save
        format.js
      end
    end
  end

  def unfollow
    @followed_id = params[:followed_id]
    @relationship = Relationship.find_by(followed_id: params[:followed_id], follower_id: current_user.id)
    @relationship.destroy
    respond_to do |format|
      format.js
    end
  end

  def followers
    @user = User.find(params[:user_id])
    @followers = @user.followers
    respond_to do |format|
      format.html
    end
  end

  def following
    @user = User.find(params[:user_id])
    @following = @user.following
    respond_to do |format|
      format.html
    end
  end
end
