module DashboardHelper
  def control_buttons class_name
    buttons = <<-EOT
      <div class='pull-right'>
        <ul class='horizontal-clean-list'>
    EOT
    begin
      buttons << <<-EOT
        <li>#{link_to fa_icon('plus-square-o', text: t('action.add')), send("new_#{class_name}_path")}</li>
      EOT
    rescue
    end
    begin
      buttons << <<-EOT
        <li>#{link_to fa_icon('archive', text: '导出'), '#'}</li>
      EOT
    rescue
    end
    buttons << <<-EOT
        </ul>
      </div>
    EOT
  end

  def table_list class_name, objects, attributes
    <<-EOT
      <table class='table table-striped'>
        <thead>
          <tr>
            <th width='50'>ID</th>
            #{attributes.map { |attribute| "<th width='100'>#{t("activerecord.attributes.#{class_name}.#{attribute}")}</th>" }.join("\n")}
            <th width='50'>#{t('actions')}</th>
          </tr>
        </thead>
        <tbody>
          #{objects.map { |object|
            <<-EOT
              <tr>
                <td>#{link_to object.id, object}</td>
                #{attributes.map { |attribute|
                    a = object.send(attribute)
                    a = a.text if a.respond_to? :text
                    "<td>#{a}</td>"
                  }.join("\n")}
                <td>
                  <ul class='horizontal-clean-list'>
                    <li>#{link_to fa_icon('edit'), send("edit_#{class_name}_path", object)}</li>
                    <li>#{link_to fa_icon('trash'), object, method: :delete, data: { confirm: "确定删除该「#{t("activerecord.models.#{class_name}")}」？" }}</li>
                  </ul>
                </td>
              </tr>
            EOT
          }.join("\n")}
        </tbody>
      </table>
      <div class='horizontal-centered'>
        #{paginate objects}
      </div>
    EOT
  end
end
