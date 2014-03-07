(function($) {

  // TODO remove when https://github.com/rails/jquery-ujs/pull/365 is merged
  $.rails.disableSelector = 'input[data-disable-with]:enabled, button[data-disable-with]:enabled, textarea[data-disable-with]:enabled';

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