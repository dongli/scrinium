class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy, :versions]
  impressionist actions: [:show], unique: [:session_hash, :user_id]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    set_draft

    respond_to do |format|
      if @article.save
        format.html { redirect_to [@article.user, @article], notice: t('message.create_success', thing: t('scrinium.article')) }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    set_draft
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to [@article.user, @article], notice: t('message.update_success', thing: t('scrinium.article')) }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: t('article.destroy_success') }
      format.json { head :no_content }
    end
  end

  def versions
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def set_draft
    case params[:commit]
    when t('action.add'), t('action.edit')
      @article.draft = false
    when t('action.save')
      @article.draft = true
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    ApplicationHelper.transform_params params, :article, [:privacy]
    params.require(:article).permit(:title,
                                    :content,
                                    :privacy,
                                    { group_ids: [] },
                                    :tag_list,
                                    { category_list: [] },
                                    :user_id)
  end
end
