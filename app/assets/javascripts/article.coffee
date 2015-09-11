# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
	# Switch 'edit' and 'preview' tabs.
	$('a#edit-content').click ->
		$('div#edit-content').show()
		$('div#preview-content').hide()
	$('a#preview-content').click ->
		$('div#edit-content').hide()
		$('div#preview-content').show()
		markdown $('textarea#article_content').val(), $('div#preview-content-placeholder')

	$('#article_privacy').change ->
		if this.value == '2'
			$('#select-groups').show()
		else
			$('#select-groups').hide()
