(function($) {

  // Adds popover right after any element
  $.fn.addPopover = function(html, classAttr) {
    return this.each(function() {
      var $this = $(this);
      $this.attr('data-popover', 'trigger');
      $this.parent().addClass('has-popover');
      $this.after(HandlebarsTemplates['popover']({ 'html': html, 'class': classAttr }));
    });
  };

  $.fn.removePopover = function() {
    return this.each(function() {
      var $this = $(this);
      $this.removeAttr('data-popover');
      $this.parent().removeClass('has-popover');
      $this.next().remove();
    })
  };

  $.fn.hidePopover = function() {
    var $popover = $(this).next('[data-popover="popover"]');
    return $popover.filter(":visible").animatecss('fadeOut faster', function(){
      $popover.hide().trigger("popover:hide");
    });
  };

  $.fn.showPopover = function() {
    var $popover = $(this).next('[data-popover="popover"]');
    $popover.filter(":hidden").show().trigger("popover:show").animatecss('fadeInUp faster');
  };

  $.fn.togglePopover = function() {
    var $popover = $(this).next('[data-popover="popover"]');
    return ( $popover.is(":hidden") ? $(this).showPopover() : $(this).hidePopover() );
  };

  $.fn.adjustPopoverContent = function() {
    return $(this).each(function() {

      // Content and viewport attributes
      var $content = $(this).find('.popover-content');
      var contentLeft  = $content.offset().left;
      var contentRight = contentLeft + $content.outerWidth();
      var viewportWidth = $(window).width();

      // Get container padding
      var $testEl = $(document.createElement('div')).attr({class: 'l-x', display: 'none'}).appendTo('body');
      var sitePadding = $testEl.css('padding-left');
      $testEl.remove();
      sitePadding = Math.round(parseFloat(sitePadding));

      // Calculate and fix out of bounds
      var overflowRight = contentRight - viewportWidth + sitePadding;
      var overflowLeft  = sitePadding - contentLeft;

      if (overflowRight > 0 || overflowLeft > 0) {
        var $tip = $(this).find('.popover-tip');
        var tipLeft = $tip.offset().left;
        var tipRight = tipLeft + $tip.outerWidth();
        var tipCompensation = 5;

        if (overflowRight > 0) {
          $content.css('margin-left', '-='+overflowRight);
          // update contentRight
          contentRight = contentRight - overflowRight;
          // check if tip is beyond the content
          if ((tipRight + tipCompensation) > contentRight) { $content.css('margin-left', '+='+(tipRight - contentRight + tipCompensation)); }
        }

        if (overflowLeft > 0)  {
          $content.css('margin-left', '+='+overflowLeft);
          // update contentLeft
          contentLeft = contentLeft + overflowLeft;
          // check if tip is beyond the content
          if ((tipLeft - tipCompensation) < contentLeft) { $content.css('margin-left', '-='+(contentLeft - tipLeft + tipCompensation)); }
        }
      }
    });
  };

  $.adjustVisiblePopovers = _.debounce(function() {
    $('[data-popover="popover"]:visible').adjustPopoverContent();
  }, 400);

  $.enablePopovers = function() {
    $(document)
      .on('click', '[data-popover]', function(e) {
        e.stopPropagation();
        if ($(this).data('popover') === 'trigger') {
          $(this).togglePopover();
          return false;
        }
      })
      .on('click', ':not([data-popover], [data-popover] *)', function() {
        $('[data-popover="popover"]:visible').prev('[data-popover="trigger"]').hidePopover();
      })
      .on('popover:show', '[data-popover="popover"]', function() {
        $(this).adjustPopoverContent();
      });

    $(window).resize(function() { $.adjustVisiblePopovers(); });
  };

}(jQuery));