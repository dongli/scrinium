class Organization < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :short_name, uniqueness: true
  translates :name, :short_name, :description

  has_many :users
  has_many :research_teams, dependent: :destroy
end
