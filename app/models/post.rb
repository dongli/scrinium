# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  group_id      :integer          not null
#  user_id       :integer          not null
#  postable_id   :integer          not null
#  postable_type :string           not null
#  sticky        :boolean          default(FALSE)
#  status        :string
#  position      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :postable, polymorphic: true

  validates :postable_id, :postable_type, :user_id, presence: true, unless: 'id.nil?'
end
