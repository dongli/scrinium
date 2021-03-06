$(document).on 'page:change', ->
  if $('div#collections').length == 1
    $('[id|=message-bus-collection]').each ->
      if not typeIsArray window.collection_channels
        window.collection_channels = []
      channel = $(this).attr('id').replace('message-bus-collection-', '/')
      window.collection_channels.push channel
      # TODO: 检查是否会重复订阅。
      MessageBus.subscribe channel, (data) ->
        $("i##{data.collectable_type}-#{data.collectable_id}").show()
  else if typeIsArray window.collection_channels
    MessageBus.unsubscribe channel for channel in window.collection_channels
