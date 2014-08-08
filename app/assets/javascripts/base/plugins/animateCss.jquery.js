(function($) {
  $.fn.animatecss = function(animation, onEndCallback) {
    return this.each(function() {
      $(this)
        .addClass("animated "+animation)
        .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
          $(this).removeClass(animation);
          if (typeof onEndCallback === 'function') { onEndCallback.apply(this); }
        });
    });
  }
}(jQuery));