require "administrate/base_dashboard"

class ArticleDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    activities: Field::HasMany.with_options(class_name: "::PublicActivity::Activity"),
    versions: Field::HasMany.with_options(class_name: "PaperTrail::Version"),
    taggings: Field::HasMany.with_options(class_name: "::ActsAsTaggableOn::Tagging"),
    base_tags: Field::HasMany.with_options(class_name: "::ActsAsTaggableOn::Tag"),
    tag_taggings: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tagging"),
    tags: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tag"),
    category_taggings: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tagging"),
    categories: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tag"),
    user: Field::BelongsTo,
    comments: Field::HasMany,
    collections: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    content: Field::Text,
    views_count: Field::Number,
    comments_count: Field::Number,
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
    :title,
    :user
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :activities,
    :versions,
    :taggings,
    :base_tags,
    :tag_taggings,
    :tags,
    :category_taggings,
    :categories,
    :user,
    :comments,
    :collections,
    :title,
    :content,
    :views_count,
    :comments_count,
    :status,
    :position,
    :last_edited_at,
    :last_commented_at,
    :deleted_at,
  ]

  # Overwrite this method to customize how articles are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(article)
  #   "Article ##{article.id}"
  # end
end
