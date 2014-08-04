$(function() {

  // fitvids
  $('.video').fitVids();

  $('select.chosen').chosen();

  $('[data-toggle=tooltip]').tooltip({animation: false});

  $('form').validate();

  $(document)
    .on('click', '[data-popover]', function(e) {
      e.stopPropagation();
      if ($(this).data('popover') === 'trigger') {
        var $popover = $(this).nextAll('[data-popover="popover"]');
        console.log($popover);
        if ($popover.is(':visible')) { $popover.animatecss('fadeOut faster', function(){ $popover.hide(); }); }
        else { $popover.show().animatecss('fadeInUp faster'); }
        return false;
      }
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