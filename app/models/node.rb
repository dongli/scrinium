# == Schema Information
#
# Table name: nodes
#
#  id            :integer          not null, primary key
#  name          :string
#  group_id      :integer
#  parent_id     :integer
#  status        :string
#  position      :integer
#  on_group_page :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Node < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :topics, dependent: :nullify

  validates :name, presence: true,  uniqueness: {scope: :group_id}
end
