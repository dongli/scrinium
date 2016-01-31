function formatRepo(user) {
  if (user.loading) return user.text;

  var markup = "<div class='select2-users clearfix'>" +
    "<div class='select2-users-avatar'><img src='" + user.profile.small_avatar_url + "' /></div>" +
    "<div class='select2-users-name'>" + user.name +
    "<div class='select2-users-email'>" + user.email + "</div>" +
    "</div></div>";

  return markup;
}

function formatRepoSelection(user) {
  return user.name
}

$(document).on('page:change', function() {
  var users_url = "/api/v1/users";
  $(".choose_user").select2({
    language: "zh-CN",
    placeholder: "请选择一个用户",
    theme: "bootstrap",
    ajax: {
      url: users_url,
      dataType: 'json',
      delay: 300,
      data: function (params) {
        return {
          q: { 'name_cont': params.term }
        };
      },
      processResults: function (data, params) {
        // parse the results into the format expected by Select2
        // since we are using custom formatting functions we do not need to
        // alter the remote JSON data, except to indicate that infinite
        // scrolling can be used
        return {
          results: data.users
        };
      },
      cache: true
    },
    escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
    templateResult: formatRepo, // omitted for brevity, see the source of this page
    templateSelection: formatRepoSelection, // omitted for brevity, see the source of this page
    minimumInputLength: 2
  });
})
