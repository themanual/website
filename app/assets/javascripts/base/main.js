$(function() {

  window.viewportUnitsBuggyfill.init();

  // Enable Fitvids
  $('.has-video').fitVids();
  // Enable form validation
  $('form').validate();
  // Enable popovers
  $.enablePopovers();
  // Form enhancements
  $('select[data-shipping-address=country]').fillCountryFromGeo();

  // Toggle Sidebar
  $(".js-toggle-sidebar").bind('click', function() {
    var SIDEBAR_SPEED = 250;
    var $sidebar = $('.js-sidebar');
    var $button  = $(this);

    if ($sidebar.is(':visible')) {
      $sidebar
        .stop(true)
        .fadeOut({duration: SIDEBAR_SPEED})
        .slideUp({duration: SIDEBAR_SPEED, queue: false });
      $button.removeClass('is-expanded');
    }
    else {
      $sidebar
        .stop(true)
        .fadeIn({duration: SIDEBAR_SPEED})
        .hide()
        .slideDown({duration: SIDEBAR_SPEED, queue: false});
      $button.addClass('is-expanded');
    }
    if (typeof analytics !== 'undefined') { analytics.track('Toggled Sidebar'); }
  });

  $(".masthead__statement__close").click(function() {
    $(this).closest(".masthead__statement").slideUp('fast');
    //$.cookie('hide_statement', '1', { path: '/', expires: 365 });
  });

  // External links
  $(document).on('click', 'a[rel="external"]', function() {
    window.open($(this).attr('href'));
    return false;
  });
});