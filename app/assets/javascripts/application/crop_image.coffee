@crop_image = (input_selector, input_name) ->
  $(input_selector).change ->
    img = new Image
    _URL = window.URL || window.webkitURL
    img.src = _URL.createObjectURL(this.files[0])
    # 弹出剪裁图片的modal。
    $('#crop-image-modal-img').attr('src', img.src)
    $('#crop-image-modal').modal('show')
    # 取消图片上传。
    $('#crop-image-cancel').click (e) ->
      location.reload()  # TODO: 有没有更好的方式。
      e.preventDefault() # 避免提交上传的图片。
    img.onload = () ->
      # 设置正常的图片显示大小。
      width1 = $('.modal-dialog').width() - 20
      width2 = img.width
      width = Math.max(width1, width2)
      if width1 > width2
        height = img.height
      else
        height = img.height * width1 / width2
      $('#crop-image-modal-img').cropper
        aspectRatio: 1
        minContainerWidth: width
        minContainerHeight: height
        crop: (data) ->
          $('.btn-file').append("""
            <input name="#{input_name}[crop_x]" value="#{Math.floor data.x}">
            <input name="#{input_name}[crop_y]" value="#{Math.floor data.y}">
            <input name="#{input_name}[crop_w]" value="#{Math.floor data.width}">
            <input name="#{input_name}[crop_h]" value="#{Math.floor data.height}">
          """)
