class Resource < ActiveRecord::Base
  belongs_to :resourceable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :collections, as: :collectable, dependent: :destroy

  mount_uploader :file, ResourceUploader
  validates_presence_of :file
  validates_presence_of :name, if: 'file == ""'

  acts_as_taggable
  acts_as_taggable_on :categories

  def user
    User.find(self.user_id)
  end

  def app
    engine = self.resourceable.class.parent_name
    engine ? engine.to_s.underscore : 'main_app'
  end

  def file_type
    Mime::EXTENSION_LOOKUP.select { |k, v| v == self.file.file.content_type }.keys.first.to_sym
  end

  def image?
    self.file.file.content_type =~ /\Aimage\/.*\Z/
  end
end
