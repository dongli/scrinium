class Organization < ActiveRecord::Base
  translates :name, :short_name, :description
end
