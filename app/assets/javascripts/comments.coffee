# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

turnOnParentComentPopover = ->
  $ ->
    $('[data-toggle="popover"]').popover
      html: true
  $('[data-toggle="popover"]').on 'inserted.bs.popover', ->
    MathJax.Hub.Queue(
      (-> MathJax.InputJax.TeX.resetEquationNumbers() if MathJax.InputJax.TeX.resetEquationNumbers()),
      ['Typeset', MathJax.Hub]
    )
  # Dismiss popover when click outside.
  $('body').on 'click', (e) ->
    $('[data-toggle="popover"]').each ->
      if !$(this).is(e.target) and $(this).has(e.target).length == 0 and $('.popover').has(e.target).length == 0
        $(this).popover 'hide'

$(document).on 'page:change', ->
  turnOnParentComentPopover()
