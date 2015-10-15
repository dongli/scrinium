class License < ActiveRecord::Base
  extend Enumerize

  belongs_to :organization

  enumerize :engine_name, in: [
    :esm
  ]
end
