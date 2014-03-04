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
          if (data.status == 'ok' && data.response.ip_country && _($countrySelect.val()).isEmpty()) {
            $countrySelect.find('option[data-code='+data.response.ip_country +']:first').prop('selected', true);
            $countrySelect.animateCss('flash');
          }
        });
      }

      /**
       *
       * 2. Recalculate shipping cost on address change
       *
       */

      // 2.1. Trigger custom address change event
      $form.on('change keyup', '[data-shipping-address]', function(event) {
        window.clearTimeout(timeout.func);
        if (event.type === 'keyup') {
          timeout.func = window.setTimeout(function(){ $form.trigger(addressChangeEvent); }, timeout.DELAY);
        } else if (event.type === 'change') {
          $form.trigger(addressChangeEvent);
        }
      });

      // 2.2. Handle custom address change event
      $form.on(addressChangeEvent, function(){
        var isAddressComplete = $(this)
            .find('[data-shipping-address][required]')
            .filter(function() { return _($.trim($(this).val())).isEmpty()})
            .length === 0;

        if (isAddressComplete) {
          $(this).updateFormShippingCost();
        }
      });

    });
  };

}(jQuery));