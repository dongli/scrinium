module Resourceable
  extend ActiveSupport::Concern

  included do
    has_many :resources, as: :resourceable, dependent: :destroy
    has_many :folders, as: :folderable, dependent: :destroy

    after_create :create_root_folder
  end

  private

  def create_root_folder
    if defined? current_user and current_user
      self.folders.create(
        name: 'root',
        user_id: current_user.id,
        folderable_id: self.id,
        folderable_type: self.class.to_s
      )
    else
      self.folders.create(
        name: 'root',
        user_id: self.id,
        folderable_id: self.id,
        folderable_type: 'User'
      )
    end
  end
end
