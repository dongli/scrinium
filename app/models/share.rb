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
