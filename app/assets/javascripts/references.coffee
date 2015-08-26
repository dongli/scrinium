# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  $('#reference_authors').select2
    tags: true
    multiple: true

  $('#reference_reference_type').change ->
    if $(this).val() != 0
      alert '对不起！现在只支持文章！'
      $(this).val(0)

  $('#input-journal-abbreviation').change ->
    $.post ROOT_PATH+'api/v1/journals/issued', {
      journal_id: $(this).val()
    }, (result) ->
      $('#reference_issue').attr('disabled', !result).attr('value', '')
