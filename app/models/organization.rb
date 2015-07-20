class Organization < ActiveRecord::Base
  translates :name, :short_name, :description

  has_many :research_teams, dependent: :destroy
end
