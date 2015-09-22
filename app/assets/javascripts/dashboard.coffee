$(document).on 'page:change', ->
  if /\/dashboard\/index$/.test(location)
    tabs = [ 'manage-users', 'manage-groups', 'manage-organizations' ]
    activateTab tabs
    turnOnTab tabs
