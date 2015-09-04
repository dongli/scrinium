module CollectionsHelper
  def is_collected? user, collectable
    not user.collections.where(
      'collectable_id = ? AND collectable_type = ?',
       collectable.id,        collectable.class
    ).empty?
  end
end
