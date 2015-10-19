# == Schema Information
#
# Table name: references
#
#  id              :integer          not null, primary key
#  publicable_id   :integer
#  publicable_type :string
#  creator_id      :integer
#  cite_key        :string
#  reference_type  :string
#  authors         :string           default([]), is an Array
#  title           :string
#  year            :string
#  volume          :string
#  issue           :string
#  pages           :string
#  doi             :string
#  abstract        :text
#  file            :string
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class ReferenceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
