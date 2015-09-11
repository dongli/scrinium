module CommentsHelper
  def max_comment_floor commentable
    res = 0
    commentable.comments.each do |c|
      break if not c.floor
      if c.leaves.empty?
        res = c.floor if res < c.floor
      else
        res = c.leaves.last.floor if res < c.leaves.last.floor
      end
    end
    return res
  end
end
