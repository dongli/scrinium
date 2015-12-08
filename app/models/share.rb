# == Schema Information
#
# Table name: shares
#
#  id             :integer          not null, primary key
#  host_id        :integer          not null
#  host_type      :string           not null
#  user_id        :integer          not null
#  shareable_id   :integer          not null
#  shareable_type :string           not null
#  folder_id      :integer
#  description    :string
#  expired_at     :string
#  status         :string
#  position       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Share < ActiveRecord::Base
  belongs_to :host, polymorphic: true
  belongs_to :user
  belongs_to :shareable, polymorphic: true

  validates :host_id, :host_type, presence: true
  validates :shareable_id, :shareable_type, presence: true
  validates :user_id, presence: true
  validates :shareable_id, uniqueness: { scope: [
    :shareable_type, :host_id, :host_type, :user_id
  ]}
end
