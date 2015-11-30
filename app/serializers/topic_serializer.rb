class TopicSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :title, :content, :views_count, :comments_count, :status, :position
end
