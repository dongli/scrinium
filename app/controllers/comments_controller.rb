class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :load_user_and_commentable
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = @commentable.comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = @commentable.comments.new
  end

  # GET /comments/new/1
  def reply
    @comment = @commentable.comments.new
    @comment.parent_id = params[:id]
  end

  # GET /comments/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @commentable.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        if @comment.parent
          if @comment.user != @comment.parent.user
            what = t('scrinium.comment')
            who = @comment.user.name
            url = url_for([@commentable.user, @commentable])+"#comment-#{@comment.id}"
            subject = t('comment.got_commented_subject', what: what)
            body = t('comment.got_commented_body', who: who, what: what, url: url)
            @comment.parent.user.notify subject, body
          end
        else
          if @comment.user != @commentable.user
            what = t('scrinium.'+@commentable.class.to_s.downcase)
            who = @comment.user.name
            url = url_for([@commentable.user, @commentable])+"#comment-#{@comment.id}"
            subject = t('comment.got_commented_subject', what: what)
            body = t('comment.got_commented_body', who: who, what: what, url: url)
            @commentable.user.notify subject, body
          end
        end
        format.html { redirect_to @commentable }
        format.json { render :show, status: :created, location: @comment }
        format.js
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @commentable }
        format.json { render :show, status: :ok, location: @comment }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @commentable }
      format.json { head :no_content }
      format.js
    end
  end

  private

  def load_user_and_commentable
    user_id, resource, commentable_id = request.path.split('/')[2,4]
    @user = User.find(user_id)
    @commentable = resource.singularize.classify.constantize.find(commentable_id)
  end

  def commentable_path
    resource, id = request.path.split('/')[1,2]
    "/#{resource}/#{id}"
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:commentable_id,
                                    :commentable_type,
                                    :content,
                                    :user_id,
                                    :parent_id,
                                    :floor)
  end
end
