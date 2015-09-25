$(document).on 'page:change', ->
  if /\/surveys\/(new|\d+\/edit)/.test(location)
    $('form').on 'click', '.remove_field', (event) ->
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('fieldset').hide()
      event.preventDefault()

    $('form').on 'click', '.add_field', (event) ->
      time = new Date().getTime()
      regexp = new RegExp($(this).data('id'), 'g')
      $(this).before($(this).data('fields').replace(regexp, time))
      event.preventDefault()
