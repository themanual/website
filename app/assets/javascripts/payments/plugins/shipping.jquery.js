(function($) {

  var shipping;

  /**
   * Shipping jQuery library for The Manual
   *
   * $base element will have .data() as such:
   *   {
   *     shipping-address: {
   *       lines:       [string],
   *       city:        [string],
   *       postal_code: [string],
   *       region:      [string],
   *       country:     [string]
   *     },
   *     shipping-cost: {
   *       subtotal:    [number],
   *       shipping:    [number],
   *       total:       [number]
   *     }
   *   }
   */

  $.shipping = shipping = {

    buttonProcessingMessage:  'Calculating shipping...',

    costUpdateAnimation:      'flash',

    addressFieldsSelector:    '[data-shipping-address]',

    subtotalFieldSelector:    '[data-shipping-cost="subtotal"]',

    dynamicFieldsSelector:    '[data-shipping-cost="shipping"],[data-shipping-cost="total"]',

    /**
     * Check if all required address fields are filled up
     * @param  {jQuery}  $base  - Base element (usually a form).
     * @return {boolean}        - True if all required address fields are filled up. False otherwise.
     */
    isAddressComplete: function($base) {
      return $base
              .find(shipping.addressFieldsSelector)
              .filter('[required]')
              .filter(function() { return _($.trim($(this).value())).isEmpty()})
              .length === 0;
    },

    /**
     * Saves address fields to .data() for comparing purposes
     * @param  {jQuery} $base             - Base element (usually a form).
     * @return {Object.<string, string>}  - Address object saved to .data(). See documentation above.
     */
    saveAddressData: function($base) {
      var address  = {};
      $base.find(shipping.addressFieldsSelector).each(function() {
        address[$(this).data('shipping-address')] = $(this).value();
      });
      $base.data('shipping-address', address);
      return address;
    },

    /**
     * Checks if current address differs from address saved in .data()
     * @param  {jQuery} $base - Base element (usually a form).
     * @return {boolean}      - True if a field has changed. False otherwise.
     */
    didAddressChange: function($base) {
      var changed = false;

      $base.find(shipping.addressFieldsSelector).each(function() {
        var key       = $(this).data('shipping-address');
        var oldValue  = ($base.data('shipping-address') && (key in $base.data('shipping-address'))) ? $base.data('shipping-address')[key] : '';

        if ($(this).value() !== oldValue) {
          changed = true;
          return;
        }
      });
      return changed;
    },

    /**
     * Recalculates costs based on new newShippingCost, saves them to .data('shipping-cost') and returns them
     * @param  {jQuery}        $base            - Base element (usually a form).
     * @param  {string,number} newShippingCost  - New shipping cost
     * @return {Object.<string, number>}        - Updated costs saved to .data(). See documentation above.
     */
    setCosts: function($base, newShippingCost) {

      // Costs
      var costs = {};
      // Shipping
      costs.shipping = parseCurrency(newShippingCost.toString());
      // Subtotal
      costs.subtotal = parseCurrency($base.find(shipping.subtotalFieldSelector).value());
      // Total
      costs.total    = (costs.subtotal + costs.shipping).toFixed(2);

      // Save
      $base.data('shipping-cost', costs);

      return costs;

    },

    /**
     * Calls jquery.loadingdots on the dynamic fields
     * @param  {jQuery} $base - Base element (usually a form).
     * @param  {string} [key] - Method to call on .loadingdots(key) to control dots.
     * @return {jQuery}       - jQuery Object with dynamic fields.
     */
    loadingDynamicFields: function($base, key) {
      return $base.find(shipping.dynamicFieldsSelector).loadingdots(key);
    },

    /**
     * Updated the dynamic fields with the calculated costs
     * @param  {jQuery} $base - Base element (usually a form)
     * @return {jQuery}       - jQuery object with dynamic fields
     */
    updateDynamicFields: function($base, animation) {

      animation = typeof animation === 'undefined' ? true : animation;
      var $fields = $base.find(shipping.dynamicFieldsSelector);

      $fields
        .loadingdots('stop')
        .each(function() {
          var $element = $(this);
          var key      = $element.data('shipping-cost');
          var value    = $base.data('shipping-cost')[key];
          $element.value(prefixCurrency(value));
        });

      if (animation) {
        $fields.animatecss(typeof animation === 'string' ? animation : shipping.costUpdateAnimation);
      };

      return $fields;
    },

    /**
     * Fetches shipping cost for the address in the form
     * @param  {jQuery}   $base     - Base element (usually a form)
     * @param  {Function} callback  - Handler for AJAX response.
     * @return {jqXHR}              - jQuery XHR object
     */
    requestCostForAddress: function($base, callback) {
      var params  = {};
      $base.find(shipping.addressFieldsSelector).each(function() {
        var key = $(this).data('shipping-address');
        if (key === 'country')  { params[key] = $(this).find(':selected').first().text(); }
        else                    { params[key] = $(this).value(); }
      });
      return $.getEstimatedShippingCost(params, callback);
    },

    /**
     * Enable or disable the form
     * @param  {jQuery}   $base           - Base element (usually a form)
     * @param  {boolean}  enableOrDisable - Boolean indicating whether to enable or disable the form
     * @return {jQuery}                   - Base element (usually a form)
     */
    toggleForm: function($base, enableOrDisable) {
      if (enableOrDisable === false) {
        $base.disableFormElementsWith(shipping.buttonProcessingMessage);
      }
      else {
        $.rails.enableFormElements($base);
      }
      return $base;
    },

    /**
     * Fetch, store, and refresh the cost for an address
     * @param  {jQuery}   $base           - Base element (usually a form)
     * @param  {Function} onAfterCallback - Callback called after updating the form
     * @return {jqXHR}                    - jQuery XHR object
     */
    updateCostForAddress: function($base, onAfterCallback) {

      // Disable the form
      shipping.toggleForm($base, false);

      // Set loading dots on the fields
      shipping.loadingDynamicFields($base);

      // Get cost from server
      return shipping.requestCostForAddress($base, function(data) {

        if (data.status !== 'ok') {
          shipping.toggleForm($base, true);
          return false;
        }

        var oldCosts = $base.data('shipping-cost');
        var newCosts = shipping.setCosts($base, data.response.cost);
        var animation = _.isEqual(oldCosts, newCosts) ? 'fadeIn' : true;

        // Only animate if costs are different
        shipping.updateDynamicFields($base, !_.isEqual(oldCosts, newCosts));

        // Save address for future comparisons
        shipping.saveAddressData($base);
        shipping.toggleForm($base, true);

        // Call optional callback
        if (_.isFunction(onAfterCallback)) { onAfterCallback($base); }

      });
    }


  };

}(jQuery));