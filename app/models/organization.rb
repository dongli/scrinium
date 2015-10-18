# == Schema Information
#
# Table name: organizations
#
#  id                :integer          not null, primary key
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  admin_id          :integer
#  status            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Organization < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :short_name, uniqueness: true
  validates :admin_id, presence: true

  has_attached_file :logo, styles: { medium: '150x150', thumb: '100x100', small: '30x30' }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  translates :name, :short_name, :description

  has_many :memberships, as: :host, dependent: :destroy
  has_many :users, through: :memberships
  has_many :organizationships
  has_many :suborganizations, through: :organizationships
  has_many :licenses, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true

  def admin
    @admin = User.find(self.admin_id) if not defined? @admin or @admin.id != self.admin_id
    @admin
  end
end
