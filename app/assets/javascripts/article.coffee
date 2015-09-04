# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
	# Switch 'edit' and 'preview' tabs.
	$('div#preview-content').hide()
	$('a#edit-content').click ->
		$('li#edit-content').addClass('active')
		$('div#edit-content').show()
		$('li#preview-content').removeClass('active')
		$('div#preview-content').hide()
	$('a#preview-content').click ->
		$('li#edit-content').removeClass('active')
		$('div#edit-content').hide()
		$('li#preview-content').addClass('active')
		$('div#preview-content').show()
		markdown $('textarea#article_content').val(), $('div#preview-content-placeholder')

	$('#article_privacy').change ->
		if this.value == '2'
			$('#select-groups').show()
		else
			$('#select-groups').hide()
