class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_group, only: [:new, :edit, :create]
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def show
    @topic.increment!(:views_count)
  end

  def new
    @topic = @group.topics.new
  end

  def edit
  end

  def create
    @topic = @group.topics.new(topic_params)
    @topic.user_id = current_user.id

    respond_to do |format|
      if @topic.save
        @group.increment! :topics_count
        format.html { redirect_to show_group_path(@group, :topics, node: @topic.node.name) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to @group }
    end
  end

  def upload_image
    file = params[:file]
    image = current_user.resources.new(name: SecureRandom.hex,
                                       resourceable_type: 'User',
                                       resourceable_id: current_user.id,
                                       user_id: current_user.id,
                                       status: 'hidden',
                                       file: file)
    image.save!
    respond_to do |format|
      format.json { render json: { link: image.file.url } }
    end
  end

  private

  def set_group
    @group = Group.friendly.find(params[:group_id])
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:user_id, :group_id, :node_id, :title,  :content, :status, :position)
  end
end
