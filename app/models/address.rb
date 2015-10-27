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

class Address < ActiveRecord::Base
  validates :name, :country, :city, :district, :zip_code, :street, presence: true

  belongs_to :addressable, polymorphic: true
end
