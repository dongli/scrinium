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

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
