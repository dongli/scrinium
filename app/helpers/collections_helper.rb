module CollectionsHelper
  def is_collected? user, collectable
    not user.collections.where(
      'collectable_id = ? AND collectable_type = ?',
       collectable.id,        collectable.class
    ).empty?
  end

  def class_escape collectable
    # 因为MessageBus不认'::'，因此需要将'::'转换为其它字符（由class_escape转换）。
    collectable.class.to_s.gsub('::', '-')
  end

  def self.class_escape collectable
    collectable.class.to_s.gsub('::', '-')
  end
end
