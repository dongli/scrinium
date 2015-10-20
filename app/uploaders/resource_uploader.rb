class ResourceUploader < BaseUploader
  def extension_white_list
    %w(jpg jpeg gif png pdf docx)
  end
end
