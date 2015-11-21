class ImageUploader < BaseUploader
  process :crop
  process resize_to_fit: [ 300, 300 ]

  version :medium do
    process resize_to_fit: [ 100, 100 ]
  end

  version :thumb do
    process resize_to_fit: [ 50, 50 ]
  end

  version :small do
    process resize_to_fit: [ 20, 20 ]
  end

  # def default_url(*args)
  #   ActionController::Base.helpers.asset_path("assets/thumb/" + ["default_avatar.png"].compact.join('_'))
  # end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  protected

  def crop
    if model.crop_x.present?
      manipulate! do |img|
        x = model.crop_x
        y = model.crop_y
        w = model.crop_w
        h = model.crop_h
        img.crop("#{w}x#{h}+#{x}+#{y}")
        img
      end
    end
  end
end
