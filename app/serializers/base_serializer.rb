class BaseSerializer < ActiveModel::Serializer
  delegate :current_user, to: :scope, allow_nil: true

  # rails g serializer group
end