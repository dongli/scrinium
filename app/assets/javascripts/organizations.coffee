$(document).on 'page:change', ->
  if /\/organizations\/\d+$/.test(location)
    turnOnTab
      info: []
      suborganizations: [ 'add-child' ]
      admin: [ 'add-engine' ]
  else if /\/organizations\/(new|\d+\/edit)/.test(location)
    $('form').on 'click', '.remove_field', (event) ->
      fieldset = $(this).closest('fieldset')
      fieldset.remove()
      event.preventDefault()

    $('form').on 'click', '.add_field', (event) ->
      time = new Date().getTime()
      regexp = new RegExp($(this).data('id'), 'g')
      $(this).before($(this).data('fields').replace(regexp, time))
      event.preventDefault()
