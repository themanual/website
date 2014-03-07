(function($) {

  $.fn.value = function(v) {
    var method = this.is(':input') && !this.is('button') ? 'val' : 'html';
    return v === undefined ? this[method]() : this[method](v);
  };

}(jQuery));