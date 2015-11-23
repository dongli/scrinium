# == Schema Information
#
# Table name: resources
#
#  id                :integer          not null, primary key
#  folder_id         :integer
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
#  uuid              :string
#  position          :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Resource < ActiveRecord::Base
  extend Enumerize

  enumerize :status, in: [
    :normal,
    :hidden,
    :trashed
  ], default: :normal, predicates: true

  mount_uploader :file, ResourceUploader

  acts_as_taggable
  acts_as_taggable_on :categories

  belongs_to :resourceable, polymorphic: true
  belongs_to :folder
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :collections, as: :collectable, dependent: :destroy

  validates :file, :name, presence: true
  validates :name, uniqueness: { scope: :folder_id }

  def user
    begin
      User.find(self.user_id)
    rescue
      self.destroy
    end
  end

  def file_type
    Mime::EXTENSION_LOOKUP.select { |k, v| v == self.file.file.content_type }.keys.first.to_sym
  end

  def image?
    self.file.file.content_type =~ /\Aimage\/.*\Z/
  end
end
