class SharesController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :set_host_and_shareable, except: [ :destroy, :back_to_top ]
  before_action :set_share, only: [ :show, :edit, :update, :destroy, :back_to_top ]

  def show
  end

  def new
    @share = @host.shares.new
    @share.shareable = @shareable
    @share.user = current_user
    if @share.save
      @shareable.share_ids << @share.id
      @shareable.save
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @share.update(share_params)
        format.html { redirect_to @share, notice: 'Share was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @share.shareable.share_ids.delete @share.id
    @share.shareable.save
    @share.destroy
    respond_to do |format|
      format.js
    end
  end

  def back_to_top
  end

  private

  def set_host_and_shareable
    if params[:host_id].present? and params[:host_type].present?
      host_id = params[:host_id]
      host_type = params[:host_type]
    elsif params[:share][:host_id].present? and params[:share][:host_type].present?
      host_id = params[:share][:host_id]
      host_type = params[:share][:host_type]
    else
      host_id = current_user.id
      host_type = 'User'
    end
    @host = host_type.classify.constantize.find(host_id)
    if params[:shareable_id].present? and params[:shareable_type].present?
      shareable_id = params[:shareable_id]
      shareable_type = params[:shareable_type]
    elsif params[:share][:shareable_id].present? and params[:share][:shareable_type].present?
      shareable_id = params[:share][:shareable_id]
      shareable_type = params[:share][:shareable_type]
    end
    @shareable = shareable_type.classify.constantize.find(shareable_id)
  end

  def set_share
    @share = Share.find(params[:id])
  end

  def share_params
    params.require(:share).permit(:description,
                                  :host_id,
                                  :host_type,
                                  :shareable_id,
                                  :shareable_type,
                                  :status,
                                  :position)
  end
end
