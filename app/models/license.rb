# == Schema Information
#
# Table name: licenses
#
#  id              :integer          not null, primary key
#  organization_id :integer          not null
#  engine_name     :string           not null
#  expired_at      :string           not null
#  max_num_seats   :integer          default(5)
#  status          :string           default("unapproved")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class License < ActiveRecord::Base
  extend Enumerize

  enumerize :engine_name, in: [
    :esm
  ]
  enumerize :status, in: [
    :unapproved,
    :approved
  ]

  belongs_to :organization

  validates :engine_name, uniqueness: { cope: :organization_id }
end
