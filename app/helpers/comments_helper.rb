module CommentsHelper
  def max_comment_floor commentable
    res = 0
    commentable.comments.each do |comment|
      break if not comment.floor
      if comment.leaves.empty?
        res = comment.floor if res < comment.floor
      else
        res = comment.leaves.last.floor if res < comment.leaves.last.floor
      end
    end
    return res
  end
end
