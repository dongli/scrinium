# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap-sprockets
#= require_tree .

setUserConsole = (heightScale, widthScale) ->
  windowHeight = $(window).innerHeight()
  userConsole = $('div[id=user-console]')
  userConsoleHeight = windowHeight*0.1*heightScale
  userConsoleWdith = 50*widthScale
  userConsole.css('height', userConsoleHeight)
  userConsole.css('width', userConsoleWdith)
  userConsole.css('left', 0)
  userConsole.css('top', (windowHeight-userConsoleHeight)*0.5)

toggleUserConsoleItems = (visible) ->
  if visible
    $('div[id=user-console-items]').css('display', 'block')
    $('i[id=user-console-icon]').css('display', 'none')
  else
    $('div[id=user-console-items]').css('display', 'none')
    $('i[id=user-console-icon]').css('display', 'block')

$(document).on 'page:change', ->
  setUserConsole(1, 1)
  toggleUserConsoleItems(false)
  $('div[id=user-console]').hover (->
      setUserConsole(2, 4)
      toggleUserConsoleItems(true)
    ), ->
      setUserConsole(1, 1)
      toggleUserConsoleItems(false)
      
  
