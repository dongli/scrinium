# == Schema Information
#
# Table name: achievements
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string
#  content    :text
#  status     :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Achievement < ActiveRecord::Base
  acts_as_tenant :user

  belongs_to :user
end
