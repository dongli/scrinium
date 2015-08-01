class ResearchRecord < ActiveRecord::Base
  is_impressionable
  belongs_to :user
end
