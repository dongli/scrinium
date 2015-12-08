$(document).on 'page:change', ->
  turnOnTab
    info: []
    suborganizations: []
    members: []
    engines: []
    admin: []

  crop_image '#organization_logo', 'organization'

  $('form').on 'click', '.remove_field', (event) ->
    fieldset = $(this).closest('fieldset')
    fieldset.remove()
    event.preventDefault()

  $('form').on 'click', '.add_field', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
