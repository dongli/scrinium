$(document).on 'page:change', ->
  $('#new-comment-notifier').click ->
    # TODO: 最好能够直接渲染出新的评论，避免用户刷新页面。
    location.reload()
    $('#save-comment').prop('disabled', false)
  # 如果页面中含有id='message-bus-comment-<commentable.class>-<commentable.id>'的
  # 元素，那么就订阅/comment-<commentable.class>-<commentable.id>频道的评论更新消息。
  if $('[id|=message-bus-comment]').length
    window.comment_channel = $('[id|=message-bus-comment]').attr('id').replace('message-bus-', '/')
    MessageBus.subscribe window.comment_channel, (data) ->
      return if $('#user-info').length and $('#user-info').data('user-id') == data.user_id
      t = $('#new-comment-notifier').text()
      n = parseInt(t.match(/\d+/))
      $('#new-comment-notifier').text(t.replace(/\d+/, n + 1))
      $('#new-comment-notifier').show()
      # 禁止用户发表新的评论，除非他已经更新了页面。
      $('#save-comment').prop('disabled', true)
  else if window.comment_channel != null
    MessageBus.unsubscribe window.comment_channel
