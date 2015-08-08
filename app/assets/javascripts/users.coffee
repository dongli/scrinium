# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  $('#upload-avatar').change ->
    reader = new FileReader
    reader.readAsDataURL @files[0]
    reader.onload = (event) ->
      $('#preview-avatar').attr('src', event.target.result)
