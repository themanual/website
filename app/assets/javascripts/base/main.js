$(function() {

  $(document).on('keypress', ':not(:input)', function(event) {
    if (!$(event.target).is(':input') && event.which == 100) {
      event.stopPropagation();
      $("html").toggleClass('debug');
    }
  });

  $('.header-nav-menu > li.has-dropdown > a').click(function() {
    $(this).parent().toggleClass('is-expanded');
    return false;
  });

  // Don't follow # hrefs
  $('a[href=#]').click(function(event) {
    return false;
  });

  // fitvids
  $('.video').fitVids();

  $('select.chosen').chosen();

  $('[data-toggle=tooltip]').tooltip({animation: false});

  $('form').validate();

});