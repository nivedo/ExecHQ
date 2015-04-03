$(document).ready(function(){
  var calendar = $("#calendar");
  if(calendar != null) {
    calendar.clndr({
      template: $('#calendar-template').html(),
      events: events,
      //[
      //  { id: '0', start: '2015-03-27', title: 'House Deep Cleaning', classtype: "cleaning" },
      //  { id: '1', start: '2015-03-29', end: '2015-03-31', title: 'Occupied by Mary Jane', classtype: "rental" },
      //  { id: '2', start: '2015-04-05', end: '2015-04-20', title: 'Occupied by Bob Dole', classtype: "rental" },
      //],
      multiDayEvents: {
        startDate: 'start',
        endDate: 'end'
      },
      clickEvents: {
        click: function(target) {
          console.log(target);
        },
        onMonthChange: function(month) {
          $('.event-link').each( function( index ) {
            $(this).click(function(event){
              $(".event").each( function() {
                $(this).removeClass("active");
              });
              $("." + $(this).attr("ref")).addClass("active");
            });
          });
          $(function() { $('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".modal_close" }); });
        }
      },
      doneRendering: function() {
        console.log('this would be a fine place to attach custom event handlers.');
      }
    });
  }

  $('.event-link').each( function( index ) {
    $(this).click(function(event){
      $(".event").each( function() {
        $(this).removeClass("active");
      });
      $("." + $(this).attr("ref")).addClass("active");
    }); 
  });

  $('#cal_link').click(function(event) {
    $desc_fields = $('#desc_fields');
    $cal_fields  = $('#cal_fields');
    $(this).parent().addClass('active');
    $("#desc_link").parent().removeClass('active');
    $desc_fields.fadeOut(300, function() {
      $cal_fields.fadeIn(300);
    });
  });

  $('#desc_link').click(function(event) {
    $desc_fields = $('#desc_fields');
    $cal_fields  = $('#cal_fields');
    $(this).parent().addClass('active');
    $("#cal_link").parent().removeClass('active');
    $cal_fields.fadeOut(300, function() {
      $desc_fields.fadeIn(300);
    });
  });
});