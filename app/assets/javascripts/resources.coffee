# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  if /\/resources\/(new|\d+\/edit)/.test(location)
    Dropzone.autoDiscover = false;
    $('#upload-file').dropzone
      paramName: 'resource[file]'
      success: (file, response) ->
        action = $('#new_resource').attr('action').replace(/resources.*$/, "resources/#{response.id}")
        $('#new_resource').attr('action', action)
        # 添加一个用于删除上传文件的链接。
        $('#new_resource').after("""
          <a rel='nofollow' data-method='delete'
            href='/users/1/resources/#{response.id}'
            id='remove-uploaded-file'></a>
        """)
      dictDefaultMessage: I18n.t('message.drop_file_here')
    # 由于用户放弃该文件，因此删除上传的文件对应的resource。
    $(document).on 'page:before-change', ->
      $('#remove-uploaded-file').click()
  else if /\/resources\/\d+/.test(location)
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
