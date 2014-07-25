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

  $(document).on('click', '[data-popover="trigger"]', function(event) {
    var $popover = $(this).nextAll('[data-popover="popover"]');
    console.log($popover.length);
    if ($popover.is(':visible')) {
      $popover.animatecss('fadeOut faster', function(){ $popover.hide(); });
    }
    else {
      $popover.show().animatecss('fadeInUp faster');
    }
    return false;
  });

  $(document)
    .on('click', '[data-popover]', function(e) {
      e.stopPropagation();
    })
    .on('click', ':not([data-popover], [data-popover] *)', function () {
      $popovers = $('[data-popover="popover"]:visible');
      $popovers.animatecss('fadeOut faster', function(){ $(this).hide(); });
    });

  $(document).on('click', '.footnote-popover a[href^="http"], .footnotes a[href^="http"]', function () {
    window.open($(this).attr('href'));
    return false;
  });

});