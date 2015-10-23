class PublicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_publication, only: [:update, :destroy]

  # POST /publications
  # POST /publications.json
  def create
    @publication = Publication.new(publication_params)

    respond_to do |format|
      if @publication.save
        format.html { redirect_to session[:previous_url].last, notice: t('message.create_success', thing: t('activerecord.models.publication')) }
      else
        format.html { redirect_to session[:previous_url].last, flash: { error: @publication.errors.to_a.first } }
      end
    end
  end

  # PATCH/PUT /publications/1
  # PATCH/PUT /publications/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: t('message.update_success', thing: t('activerecord.models.publication')) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to publications_url, notice: t('message.destroy_success', thing: t('activerecord.models.publication')) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_publication
    @publication = Publication.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def publication_params
    params.require(:publication).permit(:user_id, :reference_id, :matched_author, :status)
  end
end
