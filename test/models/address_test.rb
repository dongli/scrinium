# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  name             :string
#  addressable_id   :integer
#  addressable_type :string
#  order            :integer
#  country          :string
#  city             :string
#  district         :string
#  street           :string
#  zip_code         :string
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
