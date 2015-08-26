module ReferencesHelper
  def join_authors reference
    reference.authors[0..reference.authors.size-2].join(', ')+' and '+reference.authors.last
  end

  def citation reference
    res = ''
    res << "#{join_authors reference}, "
    res << "#{reference.year}: "
    res << "#{reference.title}, "
    res << "<i>#{reference.publicable.abbreviation}</i>, "
    res << "<b>#{reference.volume}</b>"
    res << "(#{reference.issue})" if reference.issue
    res << ", #{reference.pages}."
  end
end
