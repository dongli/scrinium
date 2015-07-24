# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# TODO: Set the default background-color and the special one elegantly.
hideAllContentBut = (suffix) ->
  $('div[id|=content]').hide()
  $('div[id=content-'+suffix+']').show()
  $('li[id|=menu]').css('background', 'white')
  $('li[id|=menu-'+suffix+']').css('background', '#EEF1F4')

# TODO: Set the default content elegantly.
$(document).on 'page:change', ->
  hideAllContentBut('manage-user')
  $('li[id|=menu]').click ->
    hideAllContentBut(@id.replace('menu-', ''))