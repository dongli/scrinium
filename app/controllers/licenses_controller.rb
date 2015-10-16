class LicensesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_license, only: [:show, :edit, :update, :destroy]

  def index
    @licenses = License.all
  end

  def show
  end

  def new
    @license = License.new
    @license.organization_id = params[:organization_id]
  end

  def edit
  end

  def create
    @license = License.new(license_params)
    respond_to do |format|
      if @license.save
        if not current_user.role == 'admin'
          # 通知管理员某机构申请添加新插件。
          organization = @license.organization
          admin = User.find_by_role('admin')
          subject = t('license.notification.subject.apply_for_engine', engine: @license.engine_name)
          body = t('license.notification.body.apply_for_engine', organization: organization.short_name,
                   engine: @license.engine_name, page: license_path(@license))
          admin.notify subject, body
          MessageBus.publish "/mailbox-#{admin.id}", { user_id: current_user.id }
          format.html { redirect_to @license, notice: t('license.message.wait_for_approval') }
        else
          format.html { redirect_to @license, notice: t('message.create_success', thing: t('scrinium.license')) }
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @license.update(license_params)
        if not current_user.role == 'admin'
          # 通知机构管理员许可证的更新。
          organization = @license.organization
          admin = organization.admin
          subject = t('license.notification.subject.license_updated', engine: @license.engine_name)
          body = t('license.notification.body.license_updated', organization: organization.short_name,
                   engine: @license.engine_name, page: license_path(@license))
          admin.notify subject, body
          MessageBus.publish "/mailbox-#{admin.id}", { user_id: current_user.id }
        end
        format.html { redirect_to @license, notice: t('message.update_success', thing: t('scrinium.license')) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @license.destroy
    respond_to do |format|
      format.html { redirect_to licenses_url, notice: t('message.destroy_success', thing: t('scrinium.license')) }
    end
  end

  private

  def set_license
    @license = License.find(params[:id])
  end

  def license_params
    params.require(:license).permit(:organization_id, :engine_name, :max_num_seats, :status, :expired_at)
  end
end
