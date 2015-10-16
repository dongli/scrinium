class License < ActiveRecord::Base
  extend Enumerize

  validates_uniqueness_of :engine_name, scope: :organization_id

  belongs_to :organization

  enumerize :engine_name, in: [
    :esm
  ]
  enumerize :status, in: [
    :unapproved,
    :approved
  ]
end
