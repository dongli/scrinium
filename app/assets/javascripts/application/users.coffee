# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  crop_image '#user_profile_attributes_avatar', 'user[profile_attributes]'
  turnOnTab
    columns: []
    publications: []
    collections: []
    resources: []
