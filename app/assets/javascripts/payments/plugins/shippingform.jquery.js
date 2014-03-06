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
       *  1. Prefill 'country' dropdown based on geoip
       *  (only requests and updated if a value hasn't been set)
       *
       */
      var $countrySelect = $form.find('select[data-shipping-address="country"]');
      if (_($countrySelect.val()).isEmpty()) {
        console.log('Fetching your country based on your IP...');
        $.getEstimatedShippingCost(function(data) {
          console.log('Got it');
          console.log(data);
          if (data.status == 'ok' && data.response.ip_country && _($countrySelect.val()).isEmpty()) {
            $countrySelect.find('option[data-code='+data.response.ip_country +']:first').prop('selected', true);
            $countrySelect.animatecss('flash');
          }
        });
      }

      /**
       *
       * 2. Recalculate shipping cost on address change
       *
       */

      // $.shipping.saveAddressData($form);

      // 2.1. Trigger custom address change event
      $form.on('change focusout keyup', '[data-shipping-address]', function(event) {

        var $form   = $(this).closest('form');

        // Disable form?
        if ($.shipping.isAddressComplete($form)) {
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

      // 2.2. Handle custom address change event
      $form.on(addressChangeEvent, function(){
        var $form   = $(this);

        if ($.shipping.isAddressComplete($form)) {
          $.shipping.updateCostForAddress($form);
        }
        else {
          $.shipping.toggleForm($form, true);
        }

      });

    });
  };

}(jQuery));