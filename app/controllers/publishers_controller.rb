class PublishersController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_publisher, only: [ :show, :edit, :update, :destroy ]

  def index
    @publishers = Publisher.all
  end

  def show
  end

  def new
    @publisher = Publisher.new
  end

  def edit
  end

  def create
    @publisher = Publisher.new(publisher_params)

    respond_to do |format|
      if @publisher.save
        format.html { redirect_to @publisher, notice: t('message.create_success', thing: t('scrinium.publisher')) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @publisher.update(publisher_params)
        format.html { redirect_to @publisher, notice: t('message.update_success', thing: t('scrinium.publisher')) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @publisher.destroy
    respond_to do |format|
      format.html { redirect_to publishers_url, notice: t('message.destroy_success', thing: t('scrinium.publisher')) }
    end
  end

  private

  def set_publisher
    @publisher = Publisher.find(params[:id])
  end

  def publisher_params
    params.require(:publisher).permit(:publisher_type,
                                      :name,
                                      :abbreviation,
                                      :short_name,
                                      :status)
  end
end
