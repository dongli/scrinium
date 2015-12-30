require "administrate/base_dashboard"

class ActivityDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    trackable_id: Field::Number,
    trackable_type: Field::String,
    owner_id: Field::Number,
    owner_type: Field::String,
    key: Field::String,
    parameters: Field::Text,
    recipient_id: Field::Number,
    recipient_type: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :trackable_id,
    :trackable_type,
    :owner_id,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :trackable_id,
    :trackable_type,
    :owner_id,
    :owner_type,
    :key,
    :parameters,
    :recipient_id,
    :recipient_type,
  ]

  # Overwrite this method to customize how activities are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(activity)
  #   "Activity ##{activity.id}"
  # end
end
