(function($) {

  $.fn.disableFormElementsWith = function(text) {
    return this.each(function() {
      var $form = $(this).is('form') ? $(this) : $(this).closest('form');
      $form.find($.rails.disableSelector).each(function() {
        $(this).data('disable-with', text);
      });
      $.rails.disableFormElements($form);
    });
  };

}(jQuery));