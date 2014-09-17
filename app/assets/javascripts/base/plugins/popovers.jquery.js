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
    return this.each(function () {
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
    $popover.filter(":hidden").trigger("popover:show").show().animatecss('fadeInUp faster');
  };

  $.fn.togglePopover = function() {
    var $popover = $(this).next('[data-popover="popover"]');
    return ( $popover.is(":hidden") ? $(this).showPopover() : $(this).hidePopover() );
  }

  $.fn.enablePopovers = function() {
    return $(this)
      .on('click', '[data-popover]', function(e) {
        e.stopPropagation();
        if ($(this).data('popover') === 'trigger') {
          $(this).togglePopover();
          return false;
        }
      })
      .on('click', ':not([data-popover], [data-popover] *)', function () {
        $('[data-popover="popover"]:visible').prev('[data-popover="trigger"]').hidePopover();
      });
  };

}(jQuery));