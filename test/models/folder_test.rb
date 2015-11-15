# == Schema Information
#
# Table name: folders
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  name            :string
#  description     :string
#  item_count      :integer
#  parent_id       :integer
#  folderable_id   :integer
#  folderable_type :string
#  status          :string
#  position        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class FolderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
