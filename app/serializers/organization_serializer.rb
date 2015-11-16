# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  logo       :string
#  admin_id   :integer
#  parent_id  :integer
#  website    :string
#  subdomain  :string
#  status     :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrganizationSerializer < BaseSerializer
  attributes :id
end
