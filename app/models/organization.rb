# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  logo       :string
#  admin_id   :integer
#  parent_id  :integer
#  website    :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ActiveRecord::Base
  mount_uploader :logo, ImageUploader

  translates :name, :short_name, :description

  belongs_to :parent, class_name: 'Organization', foreign_key: 'parent_id'
  has_many :children, class_name: 'Organization', foreign_key: 'parent_id'
  has_many :memberships, as: :host, dependent: :destroy
  has_many :users, through: :memberships
  has_many :licenses, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true

  validates :name, :short_name, uniqueness: true
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
