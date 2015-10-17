module ApplicationHelper
  def link_to_add_field name, f, association, options = {}
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      options[:partial] ||= association.to_s.singularize + "_field"
      render(options[:partial], f: builder)
    end
    class_option = options[:class] + ' add_field'
    link_to(name, '#', class: class_option, data: {id: id, fields: fields.gsub("\n", "")})
  end
end
