# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  if /\/users\/\d+\/edit/.test(location)
    crop_image '#user_profile_attributes_avatar', 'user[profile_attributes]'
  else if /\/users\/\d+/.test(location)
    turnOnTab
      activities: [ 'add-article' ]
      collections: []
      resources: []
