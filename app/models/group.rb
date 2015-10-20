# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  logo       :string
#  admin_id   :integer
#  privacy    :string           not null
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
  extend Enumerize

  enumerize :privacy, in: [ :public, :private ]

  mount_uploader :logo, ImageUploader

  acts_as_taggable
  acts_as_taggable_on :categories

  translates :name, :short_name, :description

  has_many :memberships, as: :host, dependent: :destroy
  has_many :users, class_name: 'User', through: :memberships
  has_many :group_article_associations
  has_many :articles, through: :group_article_associations

  validates_presence_of :admin_id, :privacy
  validates :logo, file_size: { less_than_or_equal_to: 2.megabytes },
                   file_content_type: { allow: [ 'image/jpeg', 'image/png' ] }

  def admin
    if not defined? @admin or @admin.id != self.admin_id
      @admin = User.find(self.admin_id)
    else
      @admin
    end
  end
end
