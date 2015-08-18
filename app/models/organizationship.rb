class Organizationship < ActiveRecord::Base
  belongs_to :organization
  belongs_to :suborganization,  class_name: 'Organization'
end
