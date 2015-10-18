# == Schema Information
#
# Table name: organizationships
#
#  id                 :integer          not null, primary key
#  organization_id    :integer
#  suborganization_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Organizationship < ActiveRecord::Base
  belongs_to :organization
  belongs_to :suborganization,  class_name: 'Organization'
end
