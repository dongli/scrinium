# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  $('div[id|=message-head]').click ->
    user_id = $('ul#left-side').attr('data-user-id')
    message_head = $(this)
    message_id = message_head.attr('id').split('-')[2]
    message_body = $("div#message-body-#{message_id}")
    message_body.toggle()
    # Reduce the unread number.
    if message_body.attr('data-read') == 'false'
      message_body.attr('data-read', 'true')
      message_head.children('i').remove()
      # Update message status in ActiveRecord.
      $.post ROOT_PATH+'api/v1/mailbox/mark_message_as_read', {
        user_id: user_id
        message_id: message_id
      }
      unread_badge = $('a#inbox').children('span.badge')
      n = parseInt(unread_badge.text())-1
      if n > 0
        unread_badge.text(n)
      else
        unread_badge.hide()
        $('a#user-menu').children('i').attr('class', 'fa fa-user')

  $('div[id|=notification-head]').click ->
    user_id = $('ul#left-side').attr('data-user-id')
    notification_head = $(this)
    notification_id = notification_head.attr('id').split('-')[2]
    notification_body = $("div#notification-body-#{notification_id}")
    notification_body.toggle()
    # Reduce the unread number.
    if notification_body.attr('data-read') == 'false'
      notification_body.attr('data-read', 'true')
      notification_head.children('i').remove()
      # Update notifications status in ActiveRecord.
      $.post ROOT_PATH+'api/v1/mailbox/mark_notification_as_read', {
        user_id: user_id
        notification_id: notification_id
      }
      unread_badge = $('a#inbox').children('span.badge')
      n = parseInt(unread_badge.text())-1
      if n > 0
        unread_badge.text(n)
      else
        unread_badge.hide()
        $('a#user-menu').children('i').attr('class', 'fa fa-user')
