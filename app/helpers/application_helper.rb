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
  def markdown text, *options
    if options.include? :without_html_safe
      @@markdown.render(text)
    else
      @@markdown.render(text).html_safe
    end
  end

  def markdown_diff a, b
    markdown(Diffy::Diff.new(a+"\n", b+"\n").to_s
    .gsub(/^\+(.*)$/, '@start_add@\1@end_add@')
    .gsub(/^-(.*)$/, '@start_remove@\1@end_remove@'),
    :without_html_safe)
    .gsub('@start_add@', '<div class="added-text">')
    .gsub('@end_add@', '</div>')
    .gsub('@start_remove@', '<div class="removed-text">')
    .gsub('@end_remove@', '</div>').html_safe
  end
end
