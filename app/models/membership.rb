# == Schema Information
#
# Table name: memberships
#
#  id              :integer          not null, primary key
#  description     :text
#  host_id         :integer          not null
#  host_type       :string           not null
#  user_id         :integer          not null
#  role            :string
#  expired_at      :datetime
#  join_type       :string
#  rejected_reason :text
#  rejected_at     :datetime
#  joined_at       :datetime
#  last_user_id    :integer
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Membership < ActiveRecord::Base
  extend Enumerize

  enumerize :role, in: [
    :admin,
    :assist_admin,
    :member
  ], default: :member
  enumerize :join_type, in: [
    :self,
    :invited,
    :added
  ]
  enumerize :status, in: [
    :unapproved,
    :approved,
    :rejected,
    :banned
  ], default: :unapproved

  belongs_to :host, polymorphic: true
  belongs_to :user

  after_create :increase_counts
  after_destroy :decrease_counts

  private

  def increase_counts
    self.host.increment! :members_count
    self.user.quotum.increment! :groups_count
  end

  def decrease_counts
    self.host.decrement! :members_count
    self.user.quotum.decrement! :groups_count
  end
end
