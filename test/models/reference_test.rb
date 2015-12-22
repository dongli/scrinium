# == Schema Information
#
# Table name: references
#
#  id             :integer          not null, primary key
#  publisher_id   :integer
#  creator_id     :integer
#  cite_key       :string
#  reference_type :string
#  authors        :string           default([]), is an Array
#  editors        :string           default([]), is an Array
#  school         :string
#  organization   :string
#  institution    :string
#  title          :string
#  booktitle      :string
#  year           :string
#  volume         :string
#  issue          :string
#  series         :string
#  pages          :string
#  edition        :string
#  chapter        :string
#  howpublished   :string
#  doi            :string
#  abstract       :text
#  file           :string
#  link           :string
#  status         :string
#  position       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class ReferenceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
