# encoding: utf-8

class ImageUploader < BaseUploader

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
