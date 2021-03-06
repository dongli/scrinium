class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.search(params[:q], options= {}).records.page(params[:page]).per(params[:per_page] || 10)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_user.articles.new(article_params)
    set_status

    respond_to do |format|
      if @article.save
        @article.create_activity :create, owner: current_user
        format.html { redirect_to @article }
      else
        format.html { render :new }
      end
    end
  end

  def update
    set_status
    respond_to do |format|
      if @article.update(article_params)
        @article.create_activity :update, owner: current_user
        format.html { redirect_to @article }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
    end
  end

  def upload_image
    file = params[:file]
    image = current_user.resources.new(name: SecureRandom.hex,
                                       resourceable_type: 'User',
                                       resourceable_id: current_user.id,
                                       user_id: current_user.id,
                                       status: 'hidden',
                                       file: file)
    image.save!
    respond_to do |format|
      format.json { render json: { link: image.file.url } }
    end
  end

  private

  def set_status
    case params[:commit]
    when t('action.add'), t('action.edit')
      @article.status = 'finished'
    when t('action.save')
      @article.status = 'draft'
    end
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title,
                                    :content,
                                    { group_ids: [] },
                                    :tag_list,
                                    { category_list: [] },
                                    :status)
  end
end
