# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
	$('a#research-record-preview').click ->
		location.reload
		title = $('input#research_record_title').val()
		content = $('textarea#research_record_content').val()
		titleElement = $('div.modal-header')
		contentElement = $('div.modal-body')
		$.post ROOT_PATH+'api/v1/markdown', { text: content }, (result) ->
			titleElement.html title
			contentElement.html result
			MathJax.Hub.Queue ['Typeset', MathJax.Hub]
		MathJax.Hub.Queue ['Typeset', MathJax.Hub]
		$('div#research-record-preview').modal('show')
	# Reload MathJax to render the math after jumping from other pages.
	MathJax.Hub.Queue ['Typeset', MathJax.Hub]
