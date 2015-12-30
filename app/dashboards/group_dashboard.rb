require "administrate/base_dashboard"

class GroupDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    resources: Field::HasMany,
    folders: Field::HasMany,
    shares: Field::HasMany,
    taggings: Field::HasMany.with_options(class_name: "::ActsAsTaggableOn::Tagging"),
    base_tags: Field::HasMany.with_options(class_name: "::ActsAsTaggableOn::Tag"),
    tag_taggings: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tagging"),
    tags: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tag"),
    category_taggings: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tagging"),
    categories: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tag"),
    translations: Field::HasMany.with_options(class_name: "Group::Translation"),
    memberships: Field::HasMany,
    users: Field::HasMany,
    posts: Field::HasMany,
    topics: Field::HasMany,
    nodes: Field::HasMany,
    id: Field::Number,
    logo: Field::String,
    admin_id: Field::Number,
    status: Field::String,
    members_count: Field::Number,
    topics_count: Field::Number,
    nodes_count: Field::Number,
    position: Field::Number,
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
    :admin_id
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :resources,
    :folders,
    :shares,
    :taggings,
    :base_tags,
    :tag_taggings,
    :tags,
    :category_taggings,
    :categories,
    :translations,
    :memberships,
    :users,
    :posts,
    :topics,
    :nodes,
    :logo,
    :admin_id,
    :status,
    :members_count,
    :topics_count,
    :nodes_count,
    :position,
    :deleted_at,
  ]

  # Overwrite this method to customize how groups are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(group)
  #   "Group ##{group.id}"
  # end
end
