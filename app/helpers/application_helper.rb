module ApplicationHelper
  EMPTY_STRING = ''.freeze

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

  def logo object, options = {}
    size = options[:size] || :thumb
    klass = options[:class] || 'logo'
    if object.logo.url
      if size.class == Symbol
        image_tag object.logo_url(size), alt: object.name, class: klass
      elsif size.class == String
        image_tag object.logo_url, alt: object.name, class: klass, size: size
      end
    else
      if size.class == Symbol
        image_tag "#{size}/default_#{object.class.to_s.downcase}_logo.png", alt: object.name, class: klass
      elsif size.class == String
        image_tag "logos/default_#{object.class.to_s.downcase}_logo.png", alt: object.name, class: klass, size: size
      end
    end
  end

  def timeago time, options = {}
    options[:class] = options[:class].blank? ? 'timeago' : [options[:class], 'timeago'].join(' ')
    options.merge!(title: time.iso8601)
    content_tag(:abbr, EMPTY_STRING, class: options[:class], title: time.iso8601) if time
  end

  def is_root_domain?
    request.path == '/' and request.host.split('.').first == 'scrinium'
  end
end
