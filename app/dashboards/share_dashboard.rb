require "administrate/base_dashboard"

class ShareDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    host: Field::Polymorphic,
    user: Field::BelongsTo,
    shareable: Field::Polymorphic,
    id: Field::Number,
    folder_id: Field::Number,
    description: Field::String,
    expired_at: Field::String,
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
    :host,
    :user,
    :shareable,
    :id,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :host,
    :user,
    :shareable,
    :folder_id,
    :description,
    :expired_at,
    :status,
    :position,
  ]

  # Overwrite this method to customize how shares are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(share)
  #   "Share ##{share.id}"
  # end
end
