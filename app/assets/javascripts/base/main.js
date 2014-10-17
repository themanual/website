$(function() {

  window.viewportUnitsBuggyfill.init();

  // Enable Fitvids
  $('.has-video').fitVids();
  // Enable form validation
  $('form').validate();
  // Enable popovers
  $.enablePopovers();

  // Toggle Sidebar
  $(".toggle-sidebar").bind('click', function() {
    var SIDEBAR_SPEED = 250;
    var $sidebar = $('.sidebar');
    var $button  = $(this);

    if ($sidebar.is(':visible')) {
      $sidebar
        .stop(true)
        .fadeOut({duration: SIDEBAR_SPEED})
        .slideUp({duration: SIDEBAR_SPEED, queue: false });
      $button.removeClass('expanded');
    }
    else {
      $sidebar
        .stop(true)
        .fadeIn({duration: SIDEBAR_SPEED})
        .hide()
        .slideDown({duration: SIDEBAR_SPEED, queue: false});
      $button.addClass('expanded');
    }
    if (typeof analytics !== 'undefined') { analytics.track('Toggled Sidebar'); }
  });

  // External links
  $(document).on('click', 'a[rel="external"]', function() {
    window.open($(this).attr('href'));
    return false;
  });
});