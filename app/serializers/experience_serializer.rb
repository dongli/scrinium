# == Schema Information
#
# Table name: experiences
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ExperienceSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :content
end
