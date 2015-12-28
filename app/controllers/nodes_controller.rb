class NodesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_group
  before_action :set_node, only: [:show, :edit, :update, :destroy]

  def index
    @nodes = @group.nodes.all
  end

  def show
  end

  def new
    @node = @group.nodes.new
  end

  def edit
  end

  def create
    @node = @group.nodes.new(node_params)

    respond_to do |format|
      if @node.save
        format.html { redirect_to session[:previous_url].last }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to session[:previous_url].last }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to session[:previous_url].last }
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_node
    @node = Node.find(params[:id])
  end

  def node_params
    params.require(:node).permit(:user_id, :name, :group_id, :status, :position)
  end
end
