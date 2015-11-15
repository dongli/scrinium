# == Schema Information
#
# Table name: collections
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  collectable_id   :integer
#  collectable_type :string
#  watched          :boolean          default(FALSE)
#  updated          :boolean          default(FALSE)
#  position         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class CollectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
