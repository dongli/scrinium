class AchievementSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :title, :content, :status, :position
end
