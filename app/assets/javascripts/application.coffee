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
#= require jcrop
#= require moment
#= require moment/zh-cn.js
#= require select2
#= require marked
#= require highlightjs
#= require i18n/translations
#= require message-bus
#= require dropzone
#= require jquery.remotipart
#= require jstree
#= require bootstrap-datepicker/core
#= require bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN.js
#= require jasny-bootstrap.min
#= require plugins/froala_editor/froala_editor_require
#= require application/custom

# ============================= Common Functions ===============================
@mathjax = (id = null) ->
  if id
    MathJax.Hub.Queue(
      (-> MathJax.InputJax.TeX.resetEquationNumbers() if MathJax.InputJax.TeX.resetEquationNumbers()),
      ['Typeset', MathJax.Hub, id]
    )
  else
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

# 打开Bootstrap中的tab，并附加一些额外的元素。
@turnOnTab = (tabs) ->
  # TODO: 使用cookie存储。
  if localStorage and localStorage['tab'] and localStorage['url'] == location.pathname
    for x, y of tabs
      if x == localStorage['tab']
        found = true
        $("#li-#{x}").addClass('active')
        $("div##{x}").addClass('active')
        $("##{z}").show() for z in y
      else
        $("#li-#{x}").removeClass('active')
        $("div##{x}").removeClass('active')
        $("##{z}").hide() for z in y
  else
    for x, y of tabs
      $("#li-#{x}").addClass('active')
      $("div##{x}").addClass('active')
      $("##{z}").show() for z in y
      break
  $('ul.nav-tabs a').click ->
    # TODO: 遇到了诡异的bug，下面这句不管用，必须手动show和hide相应的div元素！
    # $(this).tab('show')
    tab = $(this).attr('id')
    for x, y of tabs
      if x == tab
        $("#li-#{x}").addClass('active')
        $("div##{x}").addClass('active').show()
        $("##{z}").show() for z in y
      else
        $("#li-#{x}").removeClass('active')
        $("div##{x}").removeClass('active').hide()
        $("##{z}").hide() for z in y
    # 通过localStorage存储当前的tab。
    if localStorage
      localStorage['tab'] = $(this).attr('aria-controls')
      localStorage['url'] = location.pathname

@showValidationError = (inputName, errorMessage) ->
  $("label[for=#{inputName}]").attr('style', 'color: #AA3F44;')
  if $("input##{inputName}").length == 1
    input = $("input##{inputName}")
  else if $("div.#{inputName}").length == 1
    input = $("div.#{inputName}")
  input.attr('style', 'border-color: #AA3F44;')
    .after("""
      <p style='color: #AA3F44; margin-top: 5px;' id='#{inputName}-error-message'>
        #{errorMessage}
      </p>
    """)
  # 当用户开始编辑时，去除错误显示。
  input.bind 'click keypress', ->
    $("label[for=#{inputName}]").attr('style', 'color: #333333;')
    $(this).attr('style', 'border-color: #CCCCCC;')
    $("##{inputName}-error-message").remove()

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
  selectByGET 'input-publisher-abbreviation', 'api/v1/publishers/abbreviations'
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
      processResults: (data) -> {
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
    $(this).popover({
      html: true
    }).click (e) ->
      e.stopPropagation()

  # Dismiss popover when click outside.
  $('body').on 'click', (e) ->
    $('[data-toggle="popover"]').each ->
      if !$(this).is(e.target) and $(this).has(e.target).length == 0 and $('.popover').has(e.target).length == 0
        $(this).popover 'hide'

  $('.markdown').each ->
    markdown $(this).html(), $(this)

  $('.mathjax').each ->
    mathjax()

  $('[data-toggle="tooltip"]').tooltip()

  $('.datepicker').datepicker
    format: 'yyyy-mm-dd'

  # 切换用户列表显示方式。
  $('#use-user-table-list').click ->
    $('#user-table-list').show()
    $('#user-block-list').hide()
  $('#use-user-block-list').click ->
    $('#user-table-list').hide()
    $('#user-block-list').show()

  # 切换资格列表。
  $('#show-unapproved-membership-list').click ->
    $('#unapproved-membership-list').show()
    $('#approved-membership-list').hide()
  $('#show-approved-membership-list').click ->
    $('#unapproved-membership-list').hide()
    $('#approved-membership-list').show()

  # 使用Select2做标签输入。
  $('.use-select2-multiple-tags').select2
    tags: true
    multiple: true

  # 使用Moment.js显示相对时间。
  moment.locale(I18n.locale.toLowerCase())
  $('.timeago').each ->
    date = moment($(this).attr('title'))
    $(this).html(date.fromNow())

  # 是table的整行可点击。
  $('.clickable-row').click ->
    window.document.location = $(this).data('href')

  # 窗口改变大小后，检查left-column元素是否要收缩。
  resizeID = 0
  collapseLeftSide = ->
    if $('.left-column').is(':hidden')
      return if $('a[href=#left-column-content]').length > 0
      $('div.center-column').before -> """
        <div class='center' id='show-left-column-content'>
          <a href='#left-column-content' class='show-left-column-content'
           data-toggle='collapse' data-target='#left-column-content'
           aria-expanded='false' aria-controls='left-column-content'>
           <i class='fa fa-sort'></i>
          </a>
          <div class='collapse' id='left-column-content'>
            <div class='well' style='margin-left: 10%; margin-right: 10%;'>
              #{$('.left-column').html()}
            </div>
          </div>
        </div>
      """
    else
      $('div#show-left-column-content').remove()
  collapseLeftSide()
  $(window).resize ->
    clearTimeout(resizeID);
    resizeID = setTimeout(collapseLeftSide, 50)
