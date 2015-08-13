# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
	$('a#article-preview').click ->
		location.reload
		title = $('input#article_title').val()
		content = $('textarea#article_content').val()
		titleElement = $('div.modal-header')
		contentElement = $('div.modal-body')
		$.post ROOT_PATH+'api/v1/markdown', { text: content }, (result) ->
			titleElement.html title
			contentElement.html result
			MathJax.Hub.Queue(
				["resetEquationNumbers", MathJax.InputJax.TeX],
				['Typeset', MathJax.Hub]
			)
		MathJax.Hub.Queue(
			["resetEquationNumbers", MathJax.InputJax.TeX],
			['Typeset', MathJax.Hub]
		)
		$('div#article-preview').modal('show')
	# Reload MathJax to render the math after jumping from other pages.
	MathJax.Hub.Queue(
		["resetEquationNumbers", MathJax.InputJax.TeX],
		['Typeset', MathJax.Hub]
	)

	$('#article_privacy').change ->
		if this.value == '2'
			$('#select-groups').show()
		else
			$('#select-groups').hide()

	$('#article_category_list').select2
		tags: true
		multiple: true
