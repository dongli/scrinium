# == Schema Information
#
# Table name: user_options
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  front_cover :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserOptionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :front_cover
end
