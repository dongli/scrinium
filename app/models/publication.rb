class Publication < ActiveRecord::Base
  belongs_to :user
  belongs_to :reference
end
