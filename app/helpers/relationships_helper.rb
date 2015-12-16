module RelationshipsHelper
  def following? user
    current_user.following.include? user
  end
end
