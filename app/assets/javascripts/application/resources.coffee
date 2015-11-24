# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  if $('#resource-preview').length == 1
    # 当用户浏览resource时，在下载完成前显示旋转的图标。
    $('#resource-preview').load ->
      $('#spinner').hide(100)
      $(this).show(100)
