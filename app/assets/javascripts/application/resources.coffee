# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  if /\/resources\/\d+/.test(location)
    # 当用户浏览resource时，在下载完成前显示旋转的图标。
    $('#resource-preview').load ->
      $('#spinner').hide(100)
      $(this).show(100)
  else
    $('#use-resource-table-list').click ->
      $('#resource-table-list').show()
      $('#resource-block-list').hide()
    $('#use-resource-block-list').click ->
      $('#resource-table-list').hide()
      $('#resource-block-list').show()
