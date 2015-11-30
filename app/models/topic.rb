# == Schema Information
#
# Table name: topics
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  title          :string
#  content        :text
#  views_count    :integer
#  comments_count :integer
#  status         :string
#  position       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Topic < ActiveRecord::Base
end
