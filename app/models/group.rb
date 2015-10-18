# == Schema Information
#
# Table name: groups
#
#  id                :integer          not null, primary key
#  admin_id          :integer
#  privacy           :string           not null
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  status            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Group < ActiveRecord::Base
  extend Enumerize

  validates :admin_id, presence: true
  has_attached_file :logo, styles: { medium: '150x150', thumb: '100x100', small: '20x20' }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  has_many :memberships, as: :host, dependent: :destroy
  has_many :users, class_name: 'User', through: :memberships
  has_many :group_article_associations
  has_many :articles, through: :group_article_associations

  acts_as_taggable
  acts_as_taggable_on :categories

  translates :name, :short_name, :description

  validates_presence_of :privacy

  enumerize :privacy, in: [ :public, :private ]

  def admin
    @admin = User.find(self.admin_id) if not defined? @admin or @admin.id != self.admin_id
    @admin
  end
end
