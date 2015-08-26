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
#= require i18n/translations
#= require_tree .

selectByGET = (id, api_url) ->
  $('select[id='+id+']').select2(
    ajax:
      url: ROOT_PATH+api_url
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

selectByPOST = (id, api_url, post_data) ->
  $('select[id='+id+']').select2(
    ajax:
      type: 'POST'
      url: ROOT_PATH+api_url
      params: {
        contentType: 'application/json; charset=utf-8'
      }
      dataType: 'json'
      data: -> post_data
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

$(document).on 'page:change', ->
  # Using Select2 to enhance select element.
  selectByGET 'input-user-name', 'api/v1/users/names'
  selectByGET 'input-group-name', 'api/v1/groups/names'
  selectByGET 'input-organization-name', 'api/v1/organizations/names'
  selectByGET 'input-research-team-name', 'api/v1/research_teams/names'
  # TODO: Function call is not working!
  # selectByPOST 'input-group-name-for-user', 'api/v1/groups/for_user', {
  #   user_id: $('select[id=input-group-name-for-user]').data('user-id')
  # }
  $('select[id=input-group-name-for-user]').select2(
    ajax:
      type: 'POST'
      url: ROOT_PATH+'api/v1/groups/for_user'
      params: {
        contentType: 'application/json; charset=utf-8'
      }
      dataType: 'json'
      data: -> {
        user_id: $('select[id=input-group-name-for-user]').data('user-id')
      }
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
  $('[id$=_category_list]').select2
    tags: true
    multiple: true
