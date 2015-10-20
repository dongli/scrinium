# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :medium do
    process :resize_to_fit => [ 100, 100 ]
  end

  version :thumb do
    process :resize_to_fit => [ 50, 50 ]
  end

  version :small do
    process :resize_to_fit => [ 20, 20 ]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
