(function($) {

  $.fn.footnotes = function() {

    $(this).find('sup[id^="fnref:"]').each(function () {
      var $ref    = $(this);
      var $link   = $(this).find('a[href^="#fn:"]').first();
      var anchor = $link.attr('href').substring(1);
      var $note   = $(document).find('[id="'+anchor+'"]');

      // Reference contains popover
      $ref.addClass('has-popover');
      // Link is the popover trigger
      $link.attr('data-popover', 'trigger');
      // Create popover with content and data attr, and append to reference
      $("<aside />", {
        'class': 'footnote-popover is-center',
        'data-popover': 'popover'
      }).append($note.html()).appendTo($ref);
      // Hide return arrows
      $note.find('.reversefootnote').fadeOut();
    });

  };

}(jQuery));