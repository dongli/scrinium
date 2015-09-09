class Organization < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :short_name, uniqueness: true
  validates :admin_id, presence: true
  translates :name, :short_name, :description

  has_many :users
  has_many :organizationships
  has_many :suborganizations, through: :organizationships

  def admin
    @admin = User.find(self.admin_id) if not defined? @admin or @admin.id != self.admin_id
    @admin
  end
end
