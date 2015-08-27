class ReferencesController < ApplicationController
  before_action :set_reference, only: [:show, :edit, :update, :destroy]

  # GET /references
  # GET /references.json
  def index
    @references = Reference.all
  end

  # GET /references/1
  # GET /references/1.json
  def show
  end

  # GET /references/new
  def new
    @reference = Reference.new
  end

  # GET /references/1/edit
  def edit
  end

  # POST /references
  # POST /references.json
  def create
    @reference = Reference.new(reference_params)

    respond_to do |format|
      if @reference.save
        format.html { redirect_to @reference, notice: t('message.create_success', thing: t('scrinium.reference')) }
        format.json { render :show, status: :created, location: @reference }
      else
        format.html { render :new }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /references/1
  # PATCH/PUT /references/1.json
  def update
    respond_to do |format|
      if @reference.update(reference_params)
        format.html { redirect_to @reference, notice: t('message.update_success', thing: t('scrinium.reference')) }
        format.json { render :show, status: :ok, location: @reference }
      else
        format.html { render :edit }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /references/1
  # DELETE /references/1.json
  def destroy
    @reference.destroy
    respond_to do |format|
      format.html { redirect_to references_url, notice: t('message.destroy_success', thing: t('scrinium.reference')) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reference
    @reference = Reference.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reference_params
    transform_params params, :reference, [:reference_type]
    params[:reference][:authors].delete_if { |a| a.empty? }
    if not ( @reference and @reference.cite_key )
      # TODO: I only handled <first_name last_name> case. There are other cases!
      last_name = params[:reference][:authors].first.split.last
      year = params[:reference][:year]
      random_two_chars = Array.new(2) { Array('a'..'z').sample }.join
      params[:reference][:cite_key] = "#{last_name}:#{year}#{random_two_chars}"
    end
    params[:reference][:issue] ||= nil
    params.require(:reference).permit(:cite_key,
                                      :reference_type,
                                      { authors: [] },
                                      :title,
                                      :publicable_id,
                                      :publicable_type,
                                      :year,
                                      :volume,
                                      :issue,
                                      :pages,
                                      :doi,
                                      :abstract,
                                      :file)
  end
end
