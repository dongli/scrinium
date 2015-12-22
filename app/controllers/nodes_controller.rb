class NodesController < ApplicationController
  before_action :set_group
  before_action :set_node, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [ :show, :index ]

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
        format.html { redirect_to group_nodes_path(@group), notice: 'Node was successfully created.' }
        format.json { render :show, status: :created, location: @node }
      else
        format.html { render :new }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { render :show, status: :ok, location: @node }
      else
        format.html { render :edit }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to group_nodes_url(@group), notice: 'Node was successfully destroyed.' }
      format.json { head :no_content }
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
