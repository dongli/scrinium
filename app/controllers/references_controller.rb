class ReferencesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_reference, only: [ :show, :edit, :update, :destroy ]

  def index
    @references = Reference.all
  end

  def show
  end

  def new
    @reference = Reference.new
  end

  def edit
  end

  def create
    @reference = Reference.new(reference_params)

    respond_to do |format|
      if @reference.save
        format.html { redirect_to @reference, notice: t('message.create_success', thing: t('activerecord.models.reference')) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @reference.update(reference_params)
        format.html { redirect_to @reference, notice: t('message.update_success', thing: t('activerecord.models.reference')) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @reference.destroy
    respond_to do |format|
      format.html { redirect_to references_url, notice: t('message.destroy_success', thing: t('activerecord.models.reference')) }
    end
  end

  private

  def set_reference
    @reference = Reference.find(params[:id])
  end

  def reference_params
    params[:reference][:authors].delete_if { |a| a.empty? }
    params[:reference][:editors].delete_if { |a| a.empty? }
    if not ( @reference and @reference.cite_key )
      # TODO: I only handled <first_name last_name> case. There are other cases!
      last_name = params[:reference][:authors].first.split.last
      year = params[:reference][:year]
      random_two_chars = Array.new(2) { Array('a'..'z').sample }.join
      params[:reference][:cite_key] = "#{last_name}:#{year}#{random_two_chars}"
    end
    params[:reference][:issue] ||= nil
    params.require(:reference).permit(:publisher_id,
                                      :creator_id,
                                      :cite_key,
                                      :reference_type,
                                      { authors: [] },
                                      { editors: [] },
                                      :school,
                                      :organization,
                                      :institution,
                                      :title,
                                      :booktitle,
                                      :year,
                                      :volume,
                                      :issue,
                                      :series,
                                      :pages,
                                      :edition,
                                      :chapter,
                                      :howpublished,
                                      :doi,
                                      :abstract,
                                      :file,
                                      :status)
  end
end
