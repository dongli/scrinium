class Resource < ActiveRecord::Base
  belongs_to :resourceable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :collections, as: :collectable, dependent: :destroy

  has_attached_file :file
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

  validates_presence_of :name

  acts_as_taggable
  acts_as_taggable_on :categories

  enum resource_type: [
    :invalid,
    :figure,
    :datum,
    :document
  ].map { |x| I18n.t("resource.types.#{x}") }

  def user
    User.find(self.user_id)
  end
end
