# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  avatar     :string
#  gender     :string
#  title      :string
#  city       :string
#  country    :string
#  qq         :string
#  weibo      :string
#  wechat     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProfileSerializer < ActiveModel::Serializer
  attributes :user_id, :gender, :title, :city, :qq, :small_avatar_url

  def small_avatar_url
    object.avatar.url.present? ? object.avatar_url(:thumb) : '/assets/thumb/default_avatar.png'
  end

end
