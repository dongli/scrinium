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

  def search_fields class_name, *items
    fields = <<-EOT
      <style>
        .form-group {
          margin-bottom: 0;
        }
      </style>
      <div class='pull-left'>
        <%= simple_form_for @search, url: admin_#{class_name.pluralize}_path, method: :get do |f| %>
    EOT
    items.each do |item|
      fields << <<-EOT
        <%= f.input :#{item[:name]}_#{item[:term]}, label: false,
          placeholder: '#{t("activerecord.attributes.#{class_name}.#{item[:name]}")}',
          wrapper_html: { style: 'display: inline-block; width: auto !important;' }, required: false,
      EOT
      if item[:use] == 'select2'
        fields << "collection: #{item[:options]}, " if item[:options]
        fields << "value_method: :#{item[:value_method]}, " if item[:value_method]
        fields << <<-EOT
          input_html: { class: 'use-select2-multiple-tags', multiple: 'multiple' },
        EOT
      end
      fields.gsub!(/,\n$/, '')
      fields << <<-EOT
        %>
      EOT
    end
    fields << <<-EOT
          <%= f.submit t('action.search'), class: 'btn btn-success' %>
          <% if request.params[:q] %>
            <%= link_to t('action.cancel'), admin_#{class_name.pluralize}_path,
              class: 'btn btn-default' %>
          <% end %>
        <% end %>
      </div>
    EOT
  end

  def table_list class_name, objects, attributes
    <<-EOT
      <table class='table table-striped'>
        <thead>
          <tr>
            <th width='50'>ID</th>
            #{attributes.map { |attribute| "<th width='100'>#{
              if attribute.class == Symbol
                t("activerecord.attributes.#{class_name}.#{attribute}")
              else
                t("activerecord.attributes.#{attribute}")
              end
            }</th>" }.join("\n")}
            <th width='50'>#{t('actions')}</th>
          </tr>
        </thead>
        <tbody>
          #{objects.map { |object|
            <<-EOT
              <tr>
                <td>#{
                  begin
                    link_to object.id, object
                  rescue
                    object.id
                  end}</td>
                #{attributes.map { |attribute|
                    a = eval "object.#{attribute}"
                    a = a.text if a.respond_to? :text
                    "<td>#{a}</td>"
                  }.join("\n")}
                <td>
                  <ul class='horizontal-clean-list'>
                    <li>#{begin
                      link_to fa_icon('edit'), send("edit_#{class_name}_path", object)
                      rescue
                      end}</li>
                    <li>#{begin
                      link_to fa_icon('trash'), object, method: :delete, data: { confirm: "确定删除该「#{t("activerecord.models.#{class_name}")}」？" }
                      rescue
                      end}</li>
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
