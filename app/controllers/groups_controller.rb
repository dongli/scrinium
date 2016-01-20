class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_group, only: [:show, :edit, :update, :destroy, :members, :upload_image]

  def index
    @search = Group.with_translations(I18n.locale).ransack(params[:q])
    @groups = @search.result.includes(:taggings).order(:id).page(params[:page])
  end

  def show
  end

  def new
    @group = Group.new
  end

  def edit
    @category = params[:category]
  end

  def create
    @group = Group.new(group_params)
    set_crop_params
    # 创建组织的用户默认成为管理者。
    @group.admin_id = current_user.id
    respond_to do |format|
      if @group.save
        @membership = current_user.memberships.create(host_type: 'Group', host_id: @group.id, role: "admin", status: "approved")
        format.html { redirect_to @group }
      else
        format.html { render :new }
      end
    end
  end

  def update
    set_crop_params
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to session[:previous_url].last }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  def feed
    group_ids = Membership.where(user_id: current_user.id, host_type: "Group", status: "approved").pluck(:host_id)
    @topics = Topic.includes(:user).where(group_id: group_ids).order('updated_at desc')
    @posts = Post.includes(:postable).where(group_id: group_ids).order('updated_at desc')
  end

  def members
    @members = Kaminari.paginate_array(@group.memberships.where(status: 'approved').map { |x| x.user }).page(params[:page])
  end

  def upload_image
    file = params[:file]
    image = current_user.resources.new(name: SecureRandom.hex,
                                       resourceable_type: 'Group',
                                       resourceable_id: @group.id,
                                       user_id: current_user.id,
                                       status: 'hidden',
                                       file: file)
    image.save!
    respond_to do |format|
      format.json { render json: { link: image.file.url } }
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
                                  :status)
  end
end
