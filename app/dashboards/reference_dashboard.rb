require "administrate/base_dashboard"

class ReferenceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    publisher: Field::BelongsTo,
    publications: Field::HasMany,
    users: Field::HasMany,
    id: Field::Number,
    creator_id: Field::Number,
    cite_key: Field::String,
    reference_type: Field::String,
    authors: Field::String,
    editors: Field::String,
    school: Field::String,
    organization: Field::String,
    institution: Field::String,
    title: Field::String,
    booktitle: Field::String,
    year: Field::String,
    volume: Field::String,
    issue: Field::String,
    series: Field::String,
    pages: Field::String,
    edition: Field::String,
    chapter: Field::String,
    howpublished: Field::String,
    doi: Field::String,
    abstract: Field::Text,
    file: Field::String,
    link: Field::String,
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
    :publisher,
    :publications,
    :users,
    :id,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :publisher,
    :publications,
    :users,
    :creator_id,
    :cite_key,
    :reference_type,
    :authors,
    :editors,
    :school,
    :organization,
    :institution,
    :title,
    :booktitle,
    :year,
    :volume,
    :issue,
    :series,
    :pages,
    :edition,
    :chapter,
    :howpublished,
    :doi,
    :abstract,
    :file,
    :link,
    :status,
    :position,
  ]

  # Overwrite this method to customize how references are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(reference)
  #   "Reference ##{reference.id}"
  # end
end
