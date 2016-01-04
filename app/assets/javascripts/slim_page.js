//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require startup/js/flatui-checkbox

$(document).on('page:change', function() {
  $('input[type=checkbox]').checkbox()
})
