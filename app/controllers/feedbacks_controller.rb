class FeedbacksController < ApplicationController
  before_action :load_survey, except: [:index]
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.all
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
  end

  # GET /feedbacks/new
  def new
    @feedback = @survey.feedbacks.new
    @survey.questions.each do |q|
      a = @feedback.answers.build
      a.question_id = q.id
    end
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = @survey.feedbacks.new(feedback_params)
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to [ @survey, @feedback ], notice: t('message.create_success', thing: t('scrinium.feedback')) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /feedbacks/1
  # PATCH/PUT /feedbacks/1.json
  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to [ @survey, @feedback ], notice: t('message.update_success', thing: t('scrinium.feedback')) }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: t('message.destroy_success', thing: t('scrinium.feedback')) }
    end
  end

  private

  def load_survey
    survey_id = request.path.match(/\/surveys\/(\d+)/)[1]
    @survey = Survey.find(survey_id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_feedback
    @feedback = @survey.feedbacks.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def feedback_params
    @survey.questions.zip(params[:feedback][:answers_attributes]).each do |q, a|
      if q.question_type == I18n.t('question.question_types.multiple_options')
        a.last[:content] = a.last[:content].delete_if { |a| a.empty? }.join('____')
      end
    end
    params.require(:feedback).permit(:email,
                                     :survey_id,
                                     answers_attributes: [
                                      :id,
                                      :content
                                     ])
  end
end
