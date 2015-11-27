# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  trackable_id   :integer
#  trackable_type :string
#  owner_id       :integer
#  owner_type     :string
#  key            :string
#  parameters     :text
#  recipient_id   :integer
#  recipient_type :string
#  created_at     :datetime
#  updated_at     :datetime
#

class Activity < ActiveRecord::Base

end
