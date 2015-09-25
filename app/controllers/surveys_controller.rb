class SurveysController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.all
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.create(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: t('message.create_success', thing: t('scrinium.survey')) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: t('message.update_success', thing: t('scrinium.survey')) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: t('message.destroy_success', thing: t('scrinium.survey')) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_survey
    @survey = Survey.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def survey_params
    transform_params params, :survey, questions_attributes: { placeholder: :question_type }
    order = 0
    params[:survey][:questions_attributes].values.each do |q|
      q[:order] = order
      order += 1
    end
    params.require(:survey).permit(:user_id,
                                   :title,
                                   :preface,
                                   questions_attributes: [
                                    :id,
                                    :order,
                                    :content,
                                    :question_type,
                                    :accept_extra_answer,
                                    answers_attributes: [
                                      :id,
                                      :content
                                    ]
                                   ])
  end
end
