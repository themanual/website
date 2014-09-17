(function($) {

  $.fn.footnotes = function() {

    // Footnotes are only loaded on click
    $(this).on('click', 'a.footnote[href^="#fn:"]', function() {
      var $link     = $(this);
      var $sup      = $link.parent();
      var $footnote = $(document).find('[id="'+$link.attr('href').substring(1)+'"]');

      // Popover not there yet
      if (!$link.attr('data-popover')) {
        // Add popover and open it
        $link
          .addPopover($footnote.html(), "popover is-center")
          .trigger('click');
        // On hide, remove it
        $sup.on('popover:hide', function() {
          $link.removePopover();
        });
        // Don't open link
        return false;
      }
    });

    // Click handlers
    // 1. Open non-anchor links in footnote popovers and footnotes on new tabs/windows
    // 2. When clicking footnote back link, scroll up and show popover
    $(this)
      .on('click', '.footnote + .popover a:not([href^="#"]), .footnotes a:not([href^="#"])', function() {
        window.open($(this).attr('href'));
        return false;
      })
      .on('click', '.footnotes a[href^="#"]', function() {
        var $ref = $(document).find('[id="'+$(this).attr('href').substring(1)+'"]');
        $.scrollTo($ref, {
          duration: 250,
          onAfter: function() {
            if ($ref.attr('id').match(/^fnref:/)) {
              $ref.find('a[href^="#fn:"]:last-child').trigger('click');
            }
          }
        });
        return false;
      });

  };

}(jQuery));