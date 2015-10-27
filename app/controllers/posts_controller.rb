class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy, :change_sticky ]

  def show
  end

  def new
    @group = Group.find(params[:group_id])
    @post = @group.posts.new
    @post.user_id = current_user.id
    if params[:postable_id].present? and params[:postable_type].present?
      @post.postable_id = params[:postable_id]
      @post.postable_type = params[:postable_type]
      @post.save!
      @post.group.save!
      respond_to do |format|
        format.js
      end
    else
      # 创建一个新的文章。
      @postable = Article.new({
        title: "#{@post.group.short_name} - #{t('activerecord.models.post')} ##{@post.group.posts.size}",
        user_id: current_user.id,
        privacy: 'public'
      })
      @postable.save!
      @post.postable_id = @postable.id
      @post.postable_type = Article
      @post.save!
      @post.group.save!
      redirect_to edit_article_path(@postable)
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  def change_sticky
    respond_to do |format|
      format.js
    end
  end

  def post_to_groups
    respond_to do |format|
      format.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:group_id, :postable_id, :postable_type, :sticky, :status, :position)
  end
end
