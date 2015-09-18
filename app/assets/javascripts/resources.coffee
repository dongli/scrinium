# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  return if not /\/resources\/(new|\d+\/edit)/.test(location)
  Dropzone.autoDiscover = false;
  $('#upload-file').dropzone
    maxFilesize: 1
    paramName: 'resource[file]'
    addRemoveLinks: true
    success: (file, response) ->
      action = $('#new_resource').attr('action').replace(/resources.*$/, "resources/#{response.id}")
      $('#new_resource').attr('action', action)
    dictDefaultMessage: '将文件拖拽到这里'
