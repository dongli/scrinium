module ResourcesHelper
  def filter_user options
    ResourcesHelper.filter_user options
  end

  def self.filter_user options
    options.delete_at(2) if options[2].class == User
    options
  end

  def preview resource
    if @resource.image?
      image_tag @resource.file.url, class: 'center resizable'
    elsif @resource.file_type == :docx
      link_to fa_icon('file-word-o', style: 'font-size: 100px;'), @resource.file.url
    end
  end
end
