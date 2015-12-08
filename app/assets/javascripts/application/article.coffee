$(document).on 'page:change', ->
	# 切换“修改”和”预览“tabs。
	$('a#edit-content').click ->
		$('div#edit-content').show()
		$('div#preview-content').hide()
	$('a#preview-content').click ->
		$('div#edit-content').hide()
		$('div#preview-content').show()
		$('div#preview-content-placeholder').html($('textarea#article_content').val())
		mathjax 'preview-content-placeholder'
