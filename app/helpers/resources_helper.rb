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
      image_tag @resource.file.url, class: 'center resizable', id: 'resource-preview'
    elsif @resource.file_type == :docx
      link_to fa_icon('file-word-o', style: 'font-size: 100px;'), @resource.file.url, id: 'resource-preview'
    elsif @resource.file_type == :pdf
      render inline: <<-EOT
        <div class='embed-responsive embed-responsive-4by3'>
          <iframe class='embed-responsive-item' id='resource-preview' src='#{@resource.file.url}'></iframe>
        </div>
      EOT
    end
  end
end

