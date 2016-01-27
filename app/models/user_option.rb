# == Schema Information
#
# Table name: user_options
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  front_cover :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserOption < ActiveRecord::Base
  mount_uploader :front_cover, ImageUploader

  belongs_to :user
end
