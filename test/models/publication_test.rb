# == Schema Information
#
# Table name: publications
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  reference_id   :integer
#  matched_author :string
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class PublicationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
