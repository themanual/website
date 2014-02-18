(function($) {
  $.fn.animate = function(type) {
    return this.each(function() {
      $(this)
        .addClass("animated "+type)
        .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
          $(this).removeClass(type);
        });
    });
  }
}(jQuery));