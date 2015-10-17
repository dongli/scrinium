class Address < ActiveRecord::Base
  validates_presence_of :name, :country, :city, :district, :zip_code, :street

  belongs_to :addressable, polymorphic: true
end
