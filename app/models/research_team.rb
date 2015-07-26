class ResearchTeam < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :short_name, uniqueness: true
  translates :name, :short_name, :description

  belongs_to :organization
end
