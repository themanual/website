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
    console.log("Showing popover");
    var $popover = $(this).next('[data-popover="popover"]');
    $popover.filter(":hidden").show().trigger("popover:show").animatecss('fadeInUp faster');
  };

  $.fn.togglePopover = function() {
    var $popover = $(this).next('[data-popover="popover"]');
    return ( $popover.is(":hidden") ? $(this).showPopover() : $(this).hidePopover() );
  };

  $.fn.adjustPopoverContent = function() {
    // Content and viewport attributes
    var $content = $(this).find('.popover-content');
    var xLeft  = $content.offset().left;
    var xRight = xLeft + $content.outerWidth();
    var viewportWidth = $(window).width();

    // Get container padding
    var $testEl = $(document.createElement('div')).attr({class: 'l-x', display: 'none'}).appendTo('body');
    var padding = $testEl.css('padding-left');
    $testEl.remove();
    padding = Math.round(parseFloat(padding));

    // Calculate and fix out of bounds
    var offsetRight = xRight - viewportWidth + padding;
    var offsetLeft  = padding - xLeft;
    if (offsetRight > 0) {
      $content.css('margin-left', '-='+offsetRight);
      // TODO check if tip is container in popover
    }
    if (offsetLeft > 0)  {
      $content.css('margin-left', '+='+offsetLeft);
      // TODO check if tip is container in popover
    }
  };

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
        // $(this).adjustPopoverContent();
      });
  };

}(jQuery));