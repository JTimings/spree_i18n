$(document).ready(function(){ 
  $('.locale-dropdown-submit-input .dropdown-menu a').click(function (e) {
    e.preventDefault();
    $('#locale_input').val($(this).data('value'));
    $('#locale_form').submit();
    $("#locale-dropdown .dropdown-toggle").dropdown("toggle");
  });
});