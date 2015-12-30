require "administrate/base_dashboard"

class ResourceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    taggings: Field::HasMany.with_options(class_name: "::ActsAsTaggableOn::Tagging"),
    base_tags: Field::HasMany.with_options(class_name: "::ActsAsTaggableOn::Tag"),
    tag_taggings: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tagging"),
    tags: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tag"),
    category_taggings: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tagging"),
    categories: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tag"),
    resourceable: Field::Polymorphic,
    folder: Field::BelongsTo,
    comments: Field::HasMany,
    collections: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    file: Field::String,
    file_size: Field::String,
    file_type: Field::String,
    file_name: Field::String,
    user: Field::BelongsTo,
    share_ids: Field::Number,
    status: Field::String,
    uuid: Field::String,
    position: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :file_name,
    :user
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :taggings,
    :base_tags,
    :tag_taggings,
    :tags,
    :category_taggings,
    :categories,
    :resourceable,
    :folder,
    :comments,
    :collections,
    :name,
    :description,
    :file,
    :file_size,
    :file_type,
    :file_name,
    :user,
    :share_ids,
    :status,
    :uuid,
    :position,
  ]

  # Overwrite this method to customize how resources are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(resource)
  #   "Resource ##{resource.id}"
  # end
end
