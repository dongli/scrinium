module BreadcrumbHelper
  @@breadcrumbs ||= [ { title: I18n.t('global.home'), url: '/'} ]

  def add_breadcrumb title, url, options = {}
    title_ = title.to_sym
    if options[:first]
      @@breadcrumbs = [ { title: title_, url: url } ]
    elsif options[:on_nav_bar]
      @@breadcrumbs = @@breadcrumbs.take 1
      @@breadcrumbs << { title: title_, url: url }
    else
      i = @@breadcrumbs.index { |b| b[:title] == title_ }
      if i
        @@breadcrumbs = @@breadcrumbs.take i+1
      else
        @@breadcrumbs << { title: title_, url: url }
      end
    end
  end

  def render_breadcrumbs
    render partial: 'layouts/breadcrumbs', locals: { breadcrumbs: @@breadcrumbs }
  end
end