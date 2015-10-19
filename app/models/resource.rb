# == Schema Information
#
# Table name: resources
#
#  id                :integer          not null, primary key
#  name              :string
#  description       :text
#  file              :string
#  file_size         :string
#  file_type         :string
#  file_name         :string
#  user_id           :integer
#  resourceable_id   :integer
#  resourceable_type :string
#  status            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Resource < ActiveRecord::Base
  belongs_to :resourceable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :collections, as: :collectable, dependent: :destroy

  mount_uploader :file, ResourceUploader
  validates_presence_of :file
  validates_presence_of :name, on: :update
  validates_uniqueness_of :name, on: :update, scope: [ :user_id, :resourceable_type, :resourceable_id ]

  acts_as_taggable
  acts_as_taggable_on :categories

  def user
    begin
      User.find(self.user_id)
    rescue
      self.destroy
    end
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
