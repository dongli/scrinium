require "administrate/base_dashboard"

class FolderDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    folderable: Field::Polymorphic,
    resources: Field::HasMany,
    parent: Field::BelongsTo.with_options(class_name: "Folder"),
    children: Field::HasMany.with_options(class_name: "Folder"),
    id: Field::Number,
    name: Field::String,
    description: Field::String,
    items_count: Field::Number,
    parent_id: Field::Number,
    share_ids: Field::Number,
    status: Field::String,
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
    :name,
    :folderable,
    :resources,
    :parent,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :folderable,
    :resources,
    :parent,
    :children,
    :name,
    :description,
    :items_count,
    :parent_id,
    :share_ids,
    :status,
    :position,
  ]

  # Overwrite this method to customize how folders are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(folder)
  #   "Folder ##{folder.id}"
  # end
end
