module Resourceable
  extend ActiveSupport::Concern

  included do
    has_many :resources, as: :resourceable, dependent: :destroy
    has_many :folders, as: :folderable, dependent: :destroy
  end
end
