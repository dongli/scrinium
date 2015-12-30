require "administrate/base_dashboard"

class UserQuotumDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    id: Field::Number,
    max_resources_size: Field::Number.with_options(decimals: 2),
    resources_size: Field::Number.with_options(decimals: 2),
    max_articles_count: Field::Number,
    articles_count: Field::Number,
    max_groups_count: Field::Number,
    groups_count: Field::Number,
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
    :id,
    :max_resources_size,
    :resources_size,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :max_resources_size,
    :resources_size,
    :max_articles_count,
    :articles_count,
    :max_groups_count,
    :groups_count,
  ]

  # Overwrite this method to customize how user quota are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user_quotum)
  #   "UserQuotum ##{user_quotum.id}"
  # end
end
