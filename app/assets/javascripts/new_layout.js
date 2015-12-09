//// require plugins/flat-ui/js/flat-ui-pro.js
//= require plugins/jquery.backstretch.js

$(function(){
  // 后面背景图替换
  $.backstretch([
    "http://dl.dropbox.com/u/515046/www/outside.jpg"
    , "http://dl.dropbox.com/u/515046/www/garfield-interior.jpg"
    , "http://dl.dropbox.com/u/515046/www/cheers.jpg"
  ], {duration: 3000, fade: 750});

  // Focus state for append/prepend inputs
  $('.input-group').on('focus', '.form-control', function () {
    $(this).closest('.input-group, .form-group').addClass('focus');
  }).on('blur', '.form-control', function () {
    $(this).closest('.input-group, .form-group').removeClass('focus');
  });
});

var ROOT_PATH = '<%= main_app.root_url %>';