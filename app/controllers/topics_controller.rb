class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [ :show, :index ]
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :set_group

  def index
    @q = @group.topics.search(params[:q])
    @topics = @q.result.includes(:node, :user).page(params[:page] || 1)
  end

  def show
    @topic.increment!(:views_count)
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = @group.topics.new(topic_params)
    @topic.user_id = current_user.id

    respond_to do |format|
      if @topic.save
        format.html { redirect_to group_topic_path(@group, @topic), notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to group_topic_path(@group, @topic), notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to group_topics_path(@group), notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_group
      @group = Group.find(params[:group_id])
    end

    def set_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:user_id, :group_id, :node_id, :title,  :content, :status, :position)
    end
end
