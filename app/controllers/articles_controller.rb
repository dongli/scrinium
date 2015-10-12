class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy, :versions, :delete_version]
  impressionist actions: [:show], unique: [:session_hash, :user_id]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    set_draft

    respond_to do |format|
      if @article.save
        format.html { redirect_to [@article.user, @article], notice: t('message.create_success', thing: t('scrinium.article')) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    set_draft
    respond_to do |format|
      if @article.update(article_params)
        MessageBus.publish "/update-Article-#{@article.id}", {
          collectable_type: 'Article',
          collectable_id: @article.id
        }
        format.html { redirect_to [@article.user, @article], notice: t('message.update_success', thing: t('scrinium.article')) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: t('message.destroy_success', thing: t('scrinium.article')) }
    end
  end

  def versions
    respond_to do |format|
      format.html
    end
  end

  def delete_version
    if params[:version_id] == '-1'
      @article.versions.destroy_all
    else
      PaperTrail::Version.find(params[:version_id]).destroy
    end
    respond_to do |format|
      format.js
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

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title,
                                    :content,
                                    :privacy,
                                    { group_ids: [] },
                                    :tag_list,
                                    { category_list: [] },
                                    :user_id)
  end
end
