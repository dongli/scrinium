require "administrate/base_dashboard"

class MembershipDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    host: Field::Polymorphic,
    user: Field::BelongsTo,
    id: Field::Number,
    description: Field::Text,
    role: Field::String,
    expired_at: Field::DateTime,
    join_type: Field::String,
    rejected_reason: Field::Text,
    rejected_at: Field::DateTime,
    joined_at: Field::DateTime,
    last_user_id: Field::Number,
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
    :host,
    :user,
    :id,
    :description,
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
    :description,
    :role,
    :expired_at,
    :join_type,
    :rejected_reason,
    :rejected_at,
    :joined_at,
    :last_user_id,
    :status,
  ]

  # Overwrite this method to customize how memberships are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(membership)
  #   "Membership ##{membership.id}"
  # end
end
