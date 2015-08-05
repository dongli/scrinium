module ApplicationHelper
  class CodeRayify < Redcarpet::Render::HTML
    def block_code code, language
      CodeRay.scan(code, language).div(:line_number => :table)
    end
  end

  @@renderer = CodeRayify.new({
    :filter_html => true,
    :safe_link_only => true,
    :hard_wrap => true,
    :prettify => true
  })
  @@markdown = Redcarpet::Markdown.new(@@renderer, {
    :autolink => true,
    :disable_indented_code_blocks => true,
    :fenced_code_blocks => true,
    :no_intra_emphasis => true
  })
  def markdown text
    @@markdown.render(text).html_safe
  end
  def self.markdown text
    @@markdown.render(text).html_safe
  end

  def self.transform_params params, object, elements
    elements.each do |x|
      params[object][x] = params[object][x].to_i if params[object].has_key? x
    end
  end
end
