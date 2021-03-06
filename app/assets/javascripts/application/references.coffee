# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  $('#reference_reference_type').change ->
    if $(this).val() not in [ 'article', 'book' ]
      alert "对不起！暂不支持#{I18n.t("enumerize.reference.reference_type.#{$(this).val()}")}！"
      $(this).val(0)
    $('#reference-type-selection').hide()
    $('div[id*=-form]').not("##{$(this).val()}-form").remove()
    $("##{$(this).val()}-form").show()
    $('#buttons').show()
    $('#input-publisher-abbreviation').change ->
      $.post ROOT_PATH+'api/v1/publishers/issued', {
        publisher_id: $(this).val()
      }, (result) ->
        $('#reference_issue').attr('disabled', !result).attr('value', '')
