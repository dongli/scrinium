# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  host_id    :integer          not null
#  host_type  :string           not null
#  user_id    :integer          not null
#  role       :string           default("member"), not null
#  expired_at :string
#  status     :string           default("unapproved")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Membership < ActiveRecord::Base
  extend Enumerize

  belongs_to :host, polymorphic: true
  belongs_to :user

  enumerize :role, in: [
    :admin,
    :assist_admin,
    :member
  ]

  enumerize :status, in: [
    :unapproved,
    :approved,
    :banned
  ]
end
