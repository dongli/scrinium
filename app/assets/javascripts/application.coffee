# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap-sprockets
#= require select2
#= require_tree .

$(document).on 'page:change', ->
  # Using Select2 to enhance select element.
  $('select[id=input-user-full-name]').select2(
    ajax:
      url: ROOT_PATH+'api/v1/users/full_names'
      dataType: 'json'
      delay: 250
      processResults: (data) ->
        {
          results: $.map( data, (d, i) ->
            { id: d[0], text: d[1] }
          )
        }
      results: (data, page) ->
        results: data
  )
  $('select[id=input-group-name]').select2(
    ajax:
      url: ROOT_PATH+'api/v1/groups/names'
      dataType: 'json'
      delay: 250
      processResults: (data) ->
        {
          results: $.map( data, (d, i) ->
            { id: d[0], text: d[1] }
          )
        }
      results: (data, page) ->
        results: data
  )
