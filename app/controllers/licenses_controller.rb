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
  end

  def edit
  end

  def create
    @license = License.new(license_params)

    respond_to do |format|
      if @license.save
        format.html { redirect_to @license, notice: t('message.create_success', thing: t('scrinium.license')) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @license.update(license_params)
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
    params.require(:license).permit(:organization_id, :engine_name, :max_num_seats, :expired_at)
  end
end
