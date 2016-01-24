# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  $('#group_category_list').select2
    tags: true
    multiple: true
  crop_image '#group_logo', 'group'
  turnOnTab
    info: []
    resources: []
