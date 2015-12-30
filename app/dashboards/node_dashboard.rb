require "administrate/base_dashboard"

class NodeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    group: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    parent_id: Field::Number,
    topics_count: Field::Number,
    status: Field::String,
    position: Field::Number,
    on_group_page: Field::Boolean,
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
    :id,
    :name,
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
    :name,
    :parent_id,
    :topics_count,
    :status,
    :position,
    :on_group_page,
  ]

  # Overwrite this method to customize how nodes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(node)
  #   "Node ##{node.id}"
  # end
end
