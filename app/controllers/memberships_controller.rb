class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_membership, only: [:show, :edit, :update, :destroy, :reject]

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
    # TODO 不能邀请同一个用户参加群组/机构两次,同时也不可邀请自己
    @membership = User.find(params[:membership][:user_id]).memberships.new(membership_params)

    respond_to do |format|
      if @membership.save
        host = @membership.host
        host.increment! :members_count
        if @membership.join_type.self?
          # 通知管理员新用户的加入。
          subject = t('membership.notification.subject.new_user_applies_to_join_in', host: host.short_name)
          body = t('membership.notification.body.new_user_applies_to_join_in',
                   user: current_user.name,
                   host: host.short_name,
                   page: membership_path(@membership))
          @membership.host.admin.notify subject, body
          MessageBus.publish "/mailbox-#{@membership.host.admin.id}", { user_id: current_user.id }
          format.html { redirect_to session[:previous_url].last, notice: t('membership.message.wait_for_approval') }
        elsif @membership.join_type.invited?
          # 通知新用户被加入到某组织。
          subject = t('membership.notification.subject.new_user_has_been_invited_to_join_in', host: host.short_name)
          body = t('membership.notification.body.new_user_has_been_invited_to_join_in',
                 host: host.short_name, page: membership_path(@membership))
          @membership.user.notify subject, body
          MessageBus.publish "/mailbox-#{@membership.user_id}", { user_id: current_user.id }
          format.html { redirect_to session[:previous_url].last, notice: t('membership.message.wait_for_agreement') }
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @membership.update(membership_params)
        host = @membership.host
        if @membership.join_type.self?
          case @membership.status
          when 'rejected'
            subject = t('membership.notification.subject.membership_rejected',
                        host: host.short_name)
            body = t('membership.notification.body.membership_rejected',
                     host: host.short_name,
                     reason: @membership.rejected_reason,
                     page: membership_path(@membership))
          else
            # 通知用户资格的更新。
            subject = t('membership.notification.subject.membership_updated',
                        host: host.short_name)
            body = t('membership.notification.body.membership_updated',
                     host: host.short_name,
                     page: membership_path(@membership))
          end
          @membership.user.notify subject, body
          MessageBus.publish "/mailbox-#{@membership.user.id}", { user_id: current_user.id }
        elsif @membership.join_type.invited?
          # 通知管理员用户同意加入。
          subject = t('membership.notification.subject.user_agreed_to_join_in',
                      user: @membership.user.name, host: host.short_name)
          body = t('membership.notification.body.user_agreed_to_join_in',
                   user: @membership.user.name,
                   host: host.short_name,
                   page: membership_path(@membership))
          @membership.host.admin.notify subject, body
          MessageBus.publish "/mailbox-#{@membership.host.admin.id}", { user_id: current_user.id }
        end
        format.html { redirect_to @membership, notice: t('message.update_success', thing: t('activerecord.models.membership')) }
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

  def reject
    @membership.status = 'rejected'
    respond_to do |format|
      format.js
    end
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:description,
                                       :host_id,
                                       :host_type,
                                       :user_id,
                                       :role,
                                       :expired_at,
                                       :join_type,
                                       :rejected_reason,
                                       :rejected_at,
                                       :joined_at,
                                       :last_user_id,
                                       :status)
  end
end
