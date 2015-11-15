# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  name             :string
#  addressable_id   :integer
#  addressable_type :string
#  country          :string
#  city             :string
#  district         :string
#  street           :string
#  zip_code         :string
#  status           :string
#  position         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
