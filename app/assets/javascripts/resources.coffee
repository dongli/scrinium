# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  return if not /\/resources\/(new|\d+\/edit)/.test(location)
  switch $('#resource_resource_type').val()
    when '1'
      $('#preview-figure').attr('src', $('#upload-resource').attr('value'))
    else
      $('[id|="preview"]').hide()
  $('#resource_resource_type').change ->
    switch $(this).val()
      when '1'
        $('[id|="preview"]').hide()
        $('#preview-figure').show()
        previewUploadedFigure('#upload-resource', '#preview-figure')
      else
        $('[id|="preview"]').hide()
