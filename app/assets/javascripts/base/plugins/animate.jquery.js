(function($) {
  $.fn.animatecss = function(type, callback) {
    return this.each(function() {
      var klass = "animated " + type;
      $(this)
        .addClass("animated "+type)
        .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
          $(this).removeClass(type);
          if (_.isFunction(callback)) { callback(); }
        });
    });
  }
}(jQuery));