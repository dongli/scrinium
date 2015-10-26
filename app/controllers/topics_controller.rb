class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :set_topic, only: [ :show, :edit, :update, :destroy, :change_sticky ]

  def show
  end

  def new
    @group = Group.find(params[:group_id])
    @topic = @group.topics.new
    @topic.user_id = current_user.id
    if params[:topicable_id].present? and params[:topicable_type].present?
      @topic.topicable_id = params[:topicable_id]
      @topic.topicable_type = params[:topicable_type]
      @topic.save!
      @topic.group.save!
      respond_to do |format|
        format.js
      end
    else
      # 创建一个新的文章。
      @topicable = Article.new({
        title: "#{@topic.group.short_name} - #{t('activerecord.models.topic')} ##{@topic.group.topics.size}",
        user_id: current_user.id,
        privacy: 'public'
      })
      @topicable.save!
      @topic.topicable_id = @topicable.id
      @topic.topicable_type = Article
      @topic.save!
      @topic.group.save!
      redirect_to edit_article_path(@topicable)
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
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

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:group_id, :topicable_id, :topicable_type, :sticky, :status, :position)
  end
end
