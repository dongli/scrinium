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
#  position        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class License < ActiveRecord::Base
  extend Enumerize

  enumerize :engine_name, in: [
    :scrinium_esm
  ]
  enumerize :status, in: [
    :unapproved,
    :approved
  ], default: :unapproved

  belongs_to :organization

  validates :engine_name, uniqueness: { scope: :organization_id }
end
