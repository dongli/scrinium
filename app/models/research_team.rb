class ResearchTeam < ActiveRecord::Base
  translates :name, :short_name, :description

  belongs_to :organization
end
