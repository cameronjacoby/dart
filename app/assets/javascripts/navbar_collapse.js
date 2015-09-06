$(function() {
  $('.navbar-collapse').on('click', function() { 
    if ($(this).hasClass('in')) {
      $('button.navbar-toggle').click();
    }
  });  
});