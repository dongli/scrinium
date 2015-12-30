require "administrate/base_dashboard"

class CommentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    commentable: Field::Polymorphic,
    user: Field::BelongsTo,
    parent: Field::BelongsTo.with_options(class_name: "Comment"),
    children: Field::HasMany.with_options(class_name: "Comment"),
    ancestor_hierarchies: Field::HasMany.with_options(class_name: "CommentHierarchy"),
    self_and_ancestors: Field::HasMany.with_options(class_name: "Comment"),
    descendant_hierarchies: Field::HasMany.with_options(class_name: "CommentHierarchy"),
    self_and_descendants: Field::HasMany.with_options(class_name: "Comment"),
    id: Field::Number,
    content: Field::Text,
    parent_id: Field::Number,
    floor: Field::Number,
    status: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :commentable,
    :user,
    :parent,
    :children,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :commentable,
    :user,
    :parent,
    :children,
    :ancestor_hierarchies,
    :self_and_ancestors,
    :descendant_hierarchies,
    :self_and_descendants,
    :content,
    :parent_id,
    :floor,
    :status,
  ]

  # Overwrite this method to customize how comments are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(comment)
  #   "Comment ##{comment.id}"
  # end
end
