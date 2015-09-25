class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true
end
