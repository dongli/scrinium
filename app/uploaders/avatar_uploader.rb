class AvatarUploader < ImageUploader
  version :medium do
    process resize_to_fit: [100, 100]
  end

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :small do
    process resize_to_fit: [30, 30]
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default_#{model.gender || 'male'}_avatar.png"].compact.join('_'))
  end
end
