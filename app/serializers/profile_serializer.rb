class ProfileSerializer < ActiveModel::Serializer
  attributes :user_id, :gender, :title, :city, :qq, :small_avatar_url

  def small_avatar_url
    object.avatar.url.present? ? object.avatar_url(:thumb) : '/assets/thumb/default_avatar.png'
  end

end
