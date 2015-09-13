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
#= require select2
#= require marked
#= require highlightjs
#= require i18n/translations
#= require message-bus
#= require_tree .

# ============================= Common Functions ===============================
@mathjax = ->
  MathJax.Hub.Queue(
    (-> MathJax.InputJax.TeX.resetEquationNumbers() if MathJax.InputJax.TeX.resetEquationNumbers()),
    ['Typeset', MathJax.Hub]
  )

marked.setOptions
  highlight: (code) ->
    hljs.highlightAuto(code).value

@markdown = (content = null, element = null, options = {}) ->
  if element == null
    marked(content)
  else
    if options.attr?
      element.attr(options.attr, marked(content))
    else
      element.html(marked(content))
    mathjax()

@previewUploadedFigure = (uploadButtonSelector, previewSelector) ->
  $(uploadButtonSelector).change ->
    reader = new FileReader
    reader.readAsDataURL @files[0]
    reader.onload = (event) ->
      $(previewSelector).attr('src', event.target.result)

selectByGET = (id, api_url) ->
  $('select[id='+id+']').select2(
    ajax:
      url: ROOT_PATH+api_url
      dataType: 'json'
      delay: 250
      processResults: (data) ->
        {
          results: $.map( data, (d, i) ->
            { id: d[0], text: d[1] }
          )
        }
      results: (data, page) ->
        results: data
  )

selectByPOST = (id, api_url, post_data) ->
  $('select[id='+id+']').select2(
    ajax:
      type: 'POST'
      url: ROOT_PATH+api_url
      params: {
        contentType: 'application/json; charset=utf-8'
      }
      dataType: 'json'
      data: -> post_data
      delay: 250
      processResults: (data) ->
        {
          results: $.map( data, (d, i) ->
            { id: d[0], text: d[1] }
          )
        }
      results: (data, page) ->
        results: data
  )

@typeIsArray = (value) ->
  value and
    typeof value is 'object' and
    value instanceof Array and
    typeof value.length is 'number' and
    typeof value.splice is 'function' and
    not ( value.propertyIsEnumerable 'length' )

$(document).on 'page:change', ->
  # Using Select2 to enhance select element.
  selectByGET 'input-user-name', 'api/v1/users/names'
  selectByGET 'input-group-name', 'api/v1/groups/names'
  selectByGET 'input-organization-name', 'api/v1/organizations/names'
  selectByGET 'input-journal-abbreviation', 'api/v1/journals/abbreviations'
  # TODO: Function call is not working!
  # selectByPOST 'input-group-name-for-user', 'api/v1/groups/for_user', {
  #   user_id: $('select[id=input-group-name-for-user]').data('user-id')
  # }
  $('select[id=input-group-name-for-user]').select2(
    ajax:
      type: 'POST'
      url: ROOT_PATH+'api/v1/groups/for_user'
      params: {
        contentType: 'application/json; charset=utf-8'
      }
      dataType: 'json'
      data: -> {
        user_id: $('select[id=input-group-name-for-user]').data('user-id')
      }
      delay: 250
      processResults: (data) ->
        {
        results: $.map( data, (d, i) ->
          { id: d[0], text: d[1] }
        )
        }
      results: (data, page) ->
        results: data
  )
  $('[id$=_category_list]').select2
    tags: true
    multiple: true
  # Turn on Bootstrap popover.
  $('[data-toggle="popover"]').each ->
    $(this).popover
      html: true
  # Dismiss popover when click outside.
  $('body').on 'click', (e) ->
    $('[data-toggle="popover"]').each ->
      if !$(this).is(e.target) and $(this).has(e.target).length == 0 and $('.popover').has(e.target).length == 0
        $(this).popover 'hide'

  $('.markdown').each ->
    markdown $(this).html(), $(this)

  $('[data-toggle="tooltip"]').tooltip()

  previewUploadedFigure('#upload-figure', '#preview-figure')
