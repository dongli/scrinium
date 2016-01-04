//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require startup/js/flatui-checkbox

$(document).on('page:change', function() {
  $('input[type=checkbox]').checkbox()
})
