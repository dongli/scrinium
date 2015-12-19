@crop_image = (input_selector, input_name) ->
  $(input_selector).change ->
    img = new Image
    _URL = window.URL || window.webkitURL
    img.src = _URL.createObjectURL(this.files[0])
    img.onload = () ->
      $('.fileinput-preview img').cropper
        aspectRatio: 1
        crop: (data) ->
          $('.btn-file').append("""
            <input name="#{input_name}[crop_x]" value="#{Math.floor data.x}">
            <input name="#{input_name}[crop_y]" value="#{Math.floor data.y}">
            <input name="#{input_name}[crop_w]" value="#{Math.floor data.width}">
            <input name="#{input_name}[crop_h]" value="#{Math.floor data.height}">
          """)
