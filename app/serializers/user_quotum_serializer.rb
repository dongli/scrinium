class UserQuotumSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :max_resources_size, :resources_size, :max_articles_count, :articles_count, :max_groups_count, :groups_count
end
