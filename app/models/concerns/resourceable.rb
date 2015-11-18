module Resourceable
  extend ActiveSupport::Concern

  included do
    # TODO: 是否把resourceable和folderable都改为host呢？
    has_many :resources, as: :resourceable, dependent: :destroy
    has_many :folders, as: :folderable, dependent: :destroy
    has_many :shares, as: :host, dependent: :destroy
  end
end
