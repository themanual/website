(function($) {
  $.fn.classArray = function() {
    return _.compact((this.attr('class') || '').split(' '));
  }
}(jQuery));