# TODO: 制作PDF封面。
class ReferenceUploader < BaseUploader
  def extension_white_list
    %w(pdf)
  end
end
