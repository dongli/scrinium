$(document).on 'page:change', ->
  $('input[id^=sticky-]').click ->
    $("#change-#{$(this).attr('id')}").trigger('click')
