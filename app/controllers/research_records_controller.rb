class ResearchRecordsController < ApplicationController
  before_action :set_research_record, only: [:show, :edit, :update, :destroy]
  impressionist actions: [:show], unique: [:session_hash]

  # GET /research_records
  # GET /research_records.json
  def index
    @research_records = ResearchRecord.all
  end

  # GET /research_records/1
  # GET /research_records/1.json
  def show
  end

  # GET /research_records/new
  def new
    @research_record = ResearchRecord.new
  end

  # GET /research_records/1/edit
  def edit
  end

  # POST /research_records
  # POST /research_records.json
  def create
    @research_record = ResearchRecord.new(research_record_params)

    respond_to do |format|
      if @research_record.save
        format.html { redirect_to @research_record, notice: t('research_record.create_success') }
        format.json { render :show, status: :created, location: @research_record }
      else
        format.html { render :new }
        format.json { render json: @research_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /research_records/1
  # PATCH/PUT /research_records/1.json
  def update
    respond_to do |format|
      if @research_record.update(research_record_params)
        format.html { redirect_to @research_record, notice: t('research_record.update_success') }
        format.json { render :show, status: :ok, location: @research_record }
      else
        format.html { render :edit }
        format.json { render json: @research_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /research_records/1
  # DELETE /research_records/1.json
  def destroy
    @research_record.destroy
    respond_to do |format|
      format.html { redirect_to research_records_url, notice: t('research_record.destroy_success') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_research_record
    @research_record = ResearchRecord.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def research_record_params
    params.require(:research_record).permit(:title,
                                            :content,
                                            :user_id)
  end
end
