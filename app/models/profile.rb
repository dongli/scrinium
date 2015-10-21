# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  avatar     :string
#  gender     :string
#  title      :string
#  mobile     :string
#  city       :string
#  country    :string
#  qq         :string
#  weibo      :string
#  wechat     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Profile < ActiveRecord::Base
  belongs_to :user
end
