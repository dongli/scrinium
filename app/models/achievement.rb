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
  belongs_to :user
end
