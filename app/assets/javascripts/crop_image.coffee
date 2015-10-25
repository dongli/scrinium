@crop_image = (input_selector, input_name) ->
  $(input_selector).change ->
    # 获取上传头像的图片大小。
    img = new Image
    _URL = window.URL || window.webkitURL
    img.src = _URL.createObjectURL(this.files[0])
    img.onload = () ->
      if this.width != this.height
        $('.fileinput-preview img').Jcrop
          aspectRatio: 1
          onSelect: (c) ->
            $('.btn-file').append("""
              <input name="#{input_name}[crop_x]" value="#{Math.floor c.x}">
              <input name="#{input_name}[crop_y]" value="#{Math.floor c.y}">
              <input name="#{input_name}[crop_w]" value="#{Math.floor c.w}">
              <input name="#{input_name}[crop_h]" value="#{Math.floor c.h}">
            """)
