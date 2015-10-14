class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :load_app_and_commentable
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
            url = @app.url_for([ @commentable ])+"#comment-#{@comment.id}"
            subject = t('comment.got_commented_subject', what: what)
            body = t('comment.got_commented_body', who: who, what: what, url: url)
            @comment.parent.user.notify subject, body
            MessageBus.publish "/mailbox-#{@comment.parent.user_id}", { user_id: @comment.user_id }
          end
        else
          if @comment.user != @commentable.user
            # what的额外逻辑是为了处理engine中的commentable。
            class_name = @commentable.class
            if class_name.parent_name
              namespace = class_name.parent_name.to_s.underscore
            else
              namespace = Rails.application.class.parent_name.to_s.underscore
            end
            what = t(namespace+'.'+class_name.to_s.split('::').last.underscore)
            who = @comment.user.name
            url = @app.url_for([ @commentable ])+"#comment-#{@comment.id}"
            subject = t('comment.got_commented_subject', what: what)
            body = t('comment.got_commented_body', who: who, what: what, url: url)
            @commentable.user.notify subject, body
            MessageBus.publish "/mailbox-#{@commentable.user.id}", { user_id: @comment.user_id }
          end
        end
        MessageBus.publish "/comment-#{@commentable.class.to_s}-#{@commentable.id}", { user_id: @comment.user_id }
        format.js
      else
        # TODO: 处理错误。
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update!(comment_params)
        format.js
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def load_app_and_commentable
    # [/<engine prefix>]/<commentable_type>/:id/comments/...
    tokens = request.path.split('/').reject(&:empty?)
    n = tokens.index('comments')
    commentable_type, commentable_id = tokens[n-2..n-1]
    if RailsEnginesHelper.engine_names.index { |x| x =~ /_#{tokens.first}$/ }
      app_name = Rails.app_class.to_s.split('::').first
      commentable_type = app_name+tokens.first.capitalize+'::'+commentable_type.singularize.classify
      @app = eval("#{app_name.downcase}_#{tokens.first}")
    else
      commentable_type = commentable_type.singularize.classify
      @app = main_app
    end
    @commentable = commentable_type.constantize.find(commentable_id)
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
