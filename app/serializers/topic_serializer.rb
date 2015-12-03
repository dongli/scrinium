# == Schema Information
#
# Table name: topics
#
#  id             :integer          not null, primary key
#  group_id       :integer
#  node_id        :integer
#  user_id        :integer
#  title          :string
#  content        :text
#  views_count    :integer
#  comments_count :integer
#  status         :string
#  position       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class TopicSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :title, :content, :views_count, :comments_count, :status, :position
end
