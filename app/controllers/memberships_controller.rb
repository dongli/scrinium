class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  def index
    @memberships = current_user.memberships
  end

  def show
  end

  def new
    @membership = current_user.memberships.new
  end

  def edit
  end

  def create
    @membership = current_user.memberships.new(membership_params)

    respond_to do |format|
      if @membership.save
        # 通知管理员新用户的加入。
        host = @membership.host
        subject = t('membership.notification.subject.new_user_applies_to_join_in', host: host.short_name)
        body = t('membership.notification.body.new_user_applies_to_join_in',
                 user: current_user.name,
                 host: host.short_name,
                 page: membership_path(@membership))
        @membership.host.admin.notify subject, body
        format.html { redirect_to session[:previous_url].last, notice: t('membership.message.wait_for_approval') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: t('message.update_success', thing: t('scrinium.membership')) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to memberships_url, notice: t('membership.message.quit_success', host: @membership.host.name) }
    end
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:host_id, :host_type, :user_id, :role, :expired_at, :status)
  end
end
