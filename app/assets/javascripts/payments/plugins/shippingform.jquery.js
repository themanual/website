(function($) {

  $.fn.shippingForm = function() {
    return this.each(function() {

      var $form = $(this);
      var addressChangeEvent = 'addresschange';
      var timeout = {
        func:   null,
        DELAY:  1000
      };

      /**
       *
       * 1. Recalculate shipping cost on address change
       *
       */

      // 1.1. Trigger custom address change event
      $form.on('change focusout keyup', '[data-shipping-address]', function(event) {

        var $form   = $(this).closest('form');

        // Disable form?
        if ($.shipping.isAddressComplete($form) && $.shipping.didAddressChange($form)) {
          $.shipping.toggleForm($form, false);
        }

        // Clear previous timeout
        window.clearTimeout(timeout.func);

        // Set new timeout
        if (event.type === 'keyup') {
          timeout.func = window.setTimeout(function(){
            $form.trigger(addressChangeEvent);
          }, timeout.DELAY);
        } else {
          $form.trigger(addressChangeEvent);
        }

      });

      // 1.2. Handle custom address change event
      $form.on(addressChangeEvent, function(){
        var $form   = $(this);
        // Recalculate cost if address changed
        if ($.shipping.isAddressComplete($form) && $.shipping.didAddressChange($form)) {
          $.shipping.updateCostForAddress($form);
        }
        else {
          $.shipping.toggleForm($form, true);
        }
      });

    });
  };

}(jQuery));