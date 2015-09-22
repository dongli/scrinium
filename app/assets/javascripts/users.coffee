# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  previewUploadedFigure('#upload-avatar', '#preview-avatar')

  if /\/users\/\d+$/.test(location)
    tabs = [ 'activities', 'collections', 'resources' ]
    activateTab tabs
    turnOnTab tabs
    $('ul.nav-tabs a').click ->
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
