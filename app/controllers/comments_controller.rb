class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_commentable
  before_action :set_comment, only: [ :show, :edit, :update, :destroy ]

  def index
    @comments = @commentable.comments
  end

  def show
  end

  def new
    @comment = @commentable.comments.new
  end

  def reply
    @comment = @commentable.comments.new
    @comment.parent_id = params[:id]
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    respond_to do |format|
      if @comment.save!
        MessageBus.publish "/comment-#{@commentable.class.to_s}-#{@commentable.id}", user_id: @comment.user_id
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update!(comment_params)
        format.js
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def load_commentable
    # /<commentable_type>/:id/comments/...
    commentable_type, commentable_id = request.path.split('/')[1..2]
    commentable_type = commentable_type.singularize.classify
    @commentable = commentable_type.constantize.find(commentable_id)
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commentable_id,
                                    :commentable_type,
                                    :content,
                                    :user_id,
                                    :parent_id,
                                    :floor,
                                    :status)
  end
end
