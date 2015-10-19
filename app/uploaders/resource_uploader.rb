# encoding: utf-8

class ResourceUploader < BaseUploader
  # storage :file

  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  def extension_white_list
    %w(jpg jpeg gif png pdf docx)
  end
end
