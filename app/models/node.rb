# == Schema Information
#
# Table name: nodes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  group_id   :integer
#  status     :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Node < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :name, presence: true,  uniqueness: {scope: :group_id}
end
