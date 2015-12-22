# == Schema Information
#
# Table name: shares
#
#  id             :integer          not null, primary key
#  host_id        :integer          not null
#  host_type      :string           not null
#  user_id        :integer          not null
#  shareable_id   :integer          not null
#  shareable_type :string           not null
#  folder_id      :integer
#  description    :string
#  expired_at     :string
#  status         :string
#  position       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
