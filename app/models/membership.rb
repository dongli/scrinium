class Membership < ActiveRecord::Base
  extend Enumerize

  belongs_to :host, polymorphic: true
  belongs_to :user

  enumerize :role, in: [
    :admin,
    :assist_admin,
    :member
  ]
end
