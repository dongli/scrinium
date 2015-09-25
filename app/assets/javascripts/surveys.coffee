$(document).on 'page:change', ->
  if /\/surveys\/(new|\d+\/edit)/.test(location)
    $('form').on 'click', '.remove_field', (event) ->
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('fieldset').remove()
      event.preventDefault()

    $('form').on 'click', '.add_field', (event) ->
      time = new Date().getTime()
      regexp = new RegExp($(this).data('id'), 'g')
      $(this).closest('div.right').before($(this).data('fields').replace(regexp, time))
      event.preventDefault()

    $('form').on 'click', '.move_up_field', (event) ->
      field = $(this).closest('fieldset.question-field')
      hidden_input = field.next()
      return if not field.prev().prev().is('fieldset.question-field')
      field.insertBefore(field.prev().prev())
      hidden_input.insertAfter(field)
      event.preventDefault()

    $('form').on 'click', '.move_down_field', (event) ->
      field = $(this).closest('fieldset.question-field')
      hidden_input = field.next()
      return if not field.next().next().is('fieldset.question-field')
      field.insertAfter(field.next().next().next())
      hidden_input.insertAfter(field)
      event.preventDefault()
