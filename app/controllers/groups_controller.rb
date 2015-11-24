class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_group, only: [ :show, :edit, :update, :destroy ]

  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    set_crop_params
    # 创建组织的用户默认成为管理者。
    @group.admin_id = current_user.id
    respond_to do |format|
      if @group.save
        @membership = current_user.memberships.create(host_type: 'Group', host_id: @group.id, role: "admin", status: "approved")
        format.html { redirect_to @group, notice: t('message.create_success', thing: t('activerecord.models.group')) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    set_crop_params
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: t('message.update_success', thing: t('activerecord.models.group')) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: t('message.destroy_success', thing: t('activerecord.models.group')) }
      format.json { head :no_content }
    end
  end

  private

  def set_crop_params
    if params[:group][:crop_x].present?
      @group.crop_x = params[:group][:crop_x]
      @group.crop_y = params[:group][:crop_y]
      @group.crop_w = params[:group][:crop_w]
      @group.crop_h = params[:group][:crop_h]
    end
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name,
                                  :short_name,
                                  :logo,
                                  :description,
                                  :admin_id,
                                  { article_ids: [] },
                                  :tag_list,
                                  { category_list: [] },
                                  :privacy,
                                  :status)
  end
end
