module ResourcesHelper
  def get_pdf_page_size file_path
    res = `identify #{file_path}`
    match = res.match(/PDF\s+(\d+)x(\d+)/)
    [ match[1], match[2] ]
  end

  def preview resource
    if @resource.image?
      image_tag @resource.file.url, class: 'horizontal-centered resizable', id: 'resource-preview'
    elsif @resource.file_type == :docx
      link_to fa_icon('file-word-o', style: 'font-size: 100px;'), @resource.file.url, id: 'resource-preview'
    elsif @resource.file_type == :pdf
      page_size = get_pdf_page_size @resource.file.path
      render inline: <<-EOT
        <div class='resource-container'>
          <iframe id='resource-preview'
           width='#{page_size.first}' height='#{page_size.last}'
           style='border: solid; border-color: gray;'
           src='#{@resource.file.url}'></iframe>
        </div>
        <script type='text/javascript'>
          var width = #{page_size.first};
          var height = #{page_size.last};
          var widthContainer = parseInt($('.resource-container').width());
          height = Math.round(height * widthContainer / width);
          width = widthContainer;
          $('#resource-preview').attr('width', width);
          $('#resource-preview').attr('height', height);
        </script>
      EOT
    end
  end
end
