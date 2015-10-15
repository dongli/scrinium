$(document).on 'page:change', ->
  if /\/organizations\/\d+$/.test(location)
    turnOnTab
      info: []
      suborganizations: []
      admin: []
