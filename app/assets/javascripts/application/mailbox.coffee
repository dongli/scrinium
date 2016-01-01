change_unread = ->
  $('.unread-mail-badge').each ->
    n = parseInt($(this).text())-1
    if n > 0
      $(this).text(n)
    else
      $(this).remove()
      $('#user-alert-logo').hide()
      $('#user-logo').show()

@expand_message = ->
  $('div[id|=message-head]').off('click')
  $('div[id|=message-head]').click ->
    user_id = $('ul#left-side').attr('data-user-id')
    message_head = $(this)
    message_id = message_head.attr('id').split('-')[2]
    message_body = $("div#message-body-#{message_id}")
    message_content = message_body.children('#content')
    if message_content.attr('data-marked') == 'false'
      markdown message_content.html(), message_content
      message_content.attr('data-marked', 'true')
    message_body.toggle()
    # Reduce the unread number.
    if message_body.attr('data-read') == 'false'
      message_body.attr('data-read', 'true')
      message_head.children('i').remove()
      change_unread()

@expand_notification = ->
  $('div[id|=notification-head]').off('click')
  $('div[id|=notification-head]').click ->
    user_id = $('ul#left-side').attr('data-user-id')
    notification_head = $(this)
    notification_id = notification_head.attr('id').split('-')[2]
    notification_body = $("div#notification-body-#{notification_id}")
    notification_content = notification_body.children('#content')
    if notification_content.attr('data-marked') == 'false'
      markdown notification_content.html(), notification_content
      notification_content.attr('data-marked', 'true')
    notification_body.toggle()
    # Reduce the unread number.
    if notification_body.attr('data-read') == 'false'
      notification_body.attr('data-read', 'true')
      notification_head.children('i').remove()
      change_unread()

$(document).on 'page:change', ->
  $('div#sentbox').hide()
  $('div#trash').hide()

  $('a#show-inbox').click ->
    $('div#inbox').show()
    $('li#nav-inbox').addClass('active')
    $('div#sentbox').hide()
    $('li#nav-sentbox').removeClass('active')
    $('div#trash').hide()
    $('li#nav-trash').removeClass('active')

  $('a#show-sentbox').click ->
    $('div#inbox').hide()
    $('li#nav-inbox').removeClass('active')
    $('div#sentbox').show()
    $('li#nav-sentbox').addClass('active')
    $('div#trash').hide()
    $('li#nav-trash').removeClass('active')

  $('a#show-trash').click ->
    $('div#inbox').hide()
    $('li#nav-inbox').removeClass('active')
    $('div#sentbox').hide()
    $('li#nav-sentbox').removeClass('active')
    $('div#trash').show()
    $('li#nav-trash').addClass('active')

  expand_message()
  expand_notification()

  # 收听邮件事件。
  if $('#user-info').length
    MessageBus.subscribe "/mailbox-#{$('#user-info').data('user-id')}", (data) ->
      # 设置未读闹铃。
      $('#user-alert-logo').show()
      $('#user-logo').hide()
      # 检查是否已经有未读邮件。
      $('.unread-mail-badge').each ->
        if $(this).length
          n = parseInt($(this).text())
          $(this).text(n + 1)
      if not $('.unread-mail-badge').length
        $('#mailbox-menu-item').append("<span class='badge unread-mail-badge'>1</span>")
        $('#show-inbox').append("<span class='badge unread-mail-badge'>1</span>")
      # 提示用户刷新看新邮件。
      t = $('#new-mail-notifier').text()
      n = parseInt(t.match(/\d+/))
      $('#new-mail-notifier').text(t.replace(/\d+/, n + 1))
      $('#new-mail-notifier').show()

  # 提示用户刷新页面。
  $('#new-mail-notifier').click ->
    # TODO: 最好能够直接渲染出新的邮件，避免用户刷新页面。
    location.reload()
