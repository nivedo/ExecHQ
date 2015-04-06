$(function() {
  $('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".modal_close" }); 
  // activate datepickers for all elements with a class of `datepicker`
  $('.datepicker').pikaday({ minDate: moment().toDate() });
});
