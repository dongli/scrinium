class Journal < ActiveRecord::Base
  has_many :references, as: :publicable
end
