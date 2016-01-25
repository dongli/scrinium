# == Schema Information
#
# Table name: experiences
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Experience < ActiveRecord::Base
  acts_as_tenant :user

  belongs_to :user
end
