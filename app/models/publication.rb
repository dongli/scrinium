# == Schema Information
#
# Table name: publications
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  reference_id   :integer
#  matched_author :string
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Publication < ActiveRecord::Base
  belongs_to :user
  belongs_to :reference
  validates_uniqueness_of :user_id, scope: :reference_id
end
