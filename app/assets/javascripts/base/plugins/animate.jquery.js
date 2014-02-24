(function($) {
  $.fn.animatecss = function(type, speed) {
    return this.each(function() {
      var klass = "animated " + type;
      if (speed) { klass += " " + speed; }
      $(this)
        .addClass("animated "+type)
        .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
          $(this).removeClass(type);
        });
    });
  }
}(jQuery));