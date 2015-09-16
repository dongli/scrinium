# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  previewUploadedFigure('#upload-avatar', '#preview-avatar')

  $('ul.nav-tabs a').click (e) ->
    e.preventDefault()
    $(this).tab('show')
    switch $(this).attr('href')
      when '#activities'
        $('#add-article').show()
        $('#add-resource').hide()
      when '#collections'
        $('#add-article').hide()
        $('#add-resource').hide()
      when '#resources'
        $('#add-article').hide()
        $('#add-resource').show()
