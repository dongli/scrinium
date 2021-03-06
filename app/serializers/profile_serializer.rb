# == Schema Information
#
# Table name: profiles
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  avatar      :string
#  gender      :string
#  affiliation :string
#  title       :string
#  location    :string
#  country     :string
#  signature   :string
#  bio         :text
#  contact     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ProfileSerializer < ActiveModel::Serializer
  attributes :user_id, :gender, :title, :small_avatar_url

  def small_avatar_url
    object.avatar_url(:thumb)
  end
end
