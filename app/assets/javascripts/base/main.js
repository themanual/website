$(function() {

  // Enable fastclick
  FastClick.attach(document.body);
  // Enable form validation
  $('form').validate();
  // Enable popovers
  $(document).popovers();
  // External links
  $(document).on('click', 'a[rel="external"]', function() {
    window.open($(this).attr('href'));
    return false;
  });
});