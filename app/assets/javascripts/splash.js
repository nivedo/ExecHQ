$(document).ready(function(){
  $('input.req').change(function(){
    $('input.req').removeClass('reg-success');
    $('input.req').each(function(){
      if($(this).val() != '' && $(this).val() != 'nil') {
        $(this).removeClass('reg-error');
        $(this).addClass('reg-success');
      }
    });
  });

  $('.submit').click(function(event){
    $curpart = $(this).closest('fieldset');
    if(checkError(validateInputs($curpart))) {
      event.preventDefault();
      return false;
    }
  });

  $('#signup_link').click(function(event) {
    $login = $('#login_form');
    $signup = $('#signup_form');
    $login.fadeOut(300, function() {
      $signup.fadeIn(300);
    });
  });

  $('#login_link').click(function(event) {
    $login = $('#login_form');
    $signup = $('#signup_form');
    $signup.fadeOut(300, function() {
      $login.fadeIn(300);
    });
  });

  $('#gmap_location').change(function(){
    //console.log("Hello World");
  });
})

function validateInputs(fields) {
  var errors = false;
  $reqs = fields.find('.req');
  $reqs.removeClass('reg-error');
  $reqs.removeClass('reg-success');

  $reqs.each(function(){
    if($(this).val() == '' || $(this).val() == 'nil') {
      $(this).addClass('reg-error');
      errors = true;
    } else {
      $(this).addClass('reg-success');
    }
  });

  return errors;
}

function checkError(errors) {
  return errors;
}