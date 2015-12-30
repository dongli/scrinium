require "administrate/base_dashboard"

class TopicDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    group: Field::BelongsTo,
    node: Field::BelongsTo,
    comments: Field::HasMany,
    collections: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    content: Field::Text,
    views_count: Field::Number,
    comments_count: Field::Number,
    sticky: Field::Boolean,
    elite: Field::Boolean,
    status: Field::String,
    position: Field::Number,
    last_edited_at: Field::DateTime,
    last_commented_at: Field::DateTime,
    deleted_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :group,
    :node,
    :comments,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :group,
    :node,
    :comments,
    :collections,
    :title,
    :content,
    :views_count,
    :comments_count,
    :sticky,
    :elite,
    :status,
    :position,
    :last_edited_at,
    :last_commented_at,
    :deleted_at,
  ]

  # Overwrite this method to customize how topics are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(topic)
  #   "Topic ##{topic.id}"
  # end
end
