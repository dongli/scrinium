module ReferencesHelper
  def join_authors reference, add_link = true
    if current_user and add_link
      attrs = <<-EOT
        class='author'
        data-toggle='popover'
        data-placement='bottom'
        data-title='#{I18n.t('action.add')+reference.reference_type+I18n.t('global.to')+I18n.t('scrinium.user')}'
      EOT
      authors = reference.authors.map { |a|
        "<a #{attrs} data-content='#{render partial: 'publications/form', locals: { user: current_user, reference: reference, matched_author: a, publication: Publication.new }}'>#{a}</a>"
      }
    else
      authors = reference.authors
    end
    authors[0..authors.size-2].join(', ')+' and '+authors.last
  end

  def citation reference
    res = ''
    res << "#{join_authors reference, false}, "
    res << "#{reference.year}: "
    res << "#{reference.title}, "
    res << "<i>#{reference.publicable.abbreviation}</i>, "
    res << "<b>#{reference.volume}</b>"
    res << "(#{reference.issue})" if reference.issue
    res << ", #{reference.pages}."
  end
end
