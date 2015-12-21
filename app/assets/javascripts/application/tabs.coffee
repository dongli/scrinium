# 打开Bootstrap中的tab，并附加一些额外的元素。
@turnOnTab = (tabs) ->
  # TODO: 使用cookie存储。
  if localStorage and localStorage['tab'] and localStorage['url'] == location.pathname
    for x, y of tabs
      if x == localStorage['tab']
        found = true
        $("#li-#{x}").addClass('active')
        $("div##{x}").addClass('active')
        $("##{z}").show() for z in y
      else
        $("#li-#{x}").removeClass('active')
        $("div##{x}").removeClass('active')
        $("##{z}").hide() for z in y
  else
    for x, y of tabs
      $("#li-#{x}").addClass('active')
      $("div##{x}").addClass('active')
      $("##{z}").show() for z in y
      break
  $('ul.nav-tabs a').click ->
    # TODO: 遇到了诡异的bug，下面这句不管用，必须手动show和hide相应的div元素！
    # $(this).tab('show')
    tab = $(this).attr('id')
    for x, y of tabs
      if x == tab
        $("#li-#{x}").addClass('active')
        $("div##{x}").addClass('active').show()
        $("##{z}").show() for z in y
      else
        $("#li-#{x}").removeClass('active')
        $("div##{x}").removeClass('active').hide()
        $("##{z}").hide() for z in y
    # 通过localStorage存储当前的tab。
    if localStorage
      localStorage['tab'] = $(this).attr('aria-controls')
      localStorage['url'] = location.pathname
