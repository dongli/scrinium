class Reference < ActiveRecord::Base
  validates_uniqueness_of :title, scope: :year
  validates :title, :authors, :year, :pages, presence: true
  belongs_to :publicable, polymorphic: true
  has_attached_file :file
  validates_attachment_content_type :file, content_type: ['application/pdf']

  enum reference_type: [
    :article,
    :book
  ].map { |x| I18n.t("reference.types.#{x}") }
end
