class Organization < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :short_name, uniqueness: true
  validates :admin_id, presence: true

  has_attached_file :logo, styles: { medium: '150x150', thumb: '100x100', small: '20x20' }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  translates :name, :short_name, :description

  has_many :memberships, as: :host, dependent: :destroy
  has_many :users, through: :memberships
  has_many :organizationships
  has_many :suborganizations, through: :organizationships
  has_many :licenses, dependent: :destroy

  def admin
    @admin = User.find(self.admin_id) if not defined? @admin or @admin.id != self.admin_id
    @admin
  end
end
