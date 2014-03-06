(function($) {

  var shipping;

  /**
   * Shipping jQuery library for The Manual
   *
   * Form will have .data() as such:
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
     * @param  {jQuery}  $form  - Base form.
     * @return {boolean}        - True if all required address fields are filled up. False otherwise.
     */
    isAddressComplete: function($form) {
      return $form
              .find(shipping.addressFieldsSelector)
              .filter('[required]')
              .filter(function() { return _($.trim($(this).val())).isEmpty()})
              .length === 0;
    },

    /**
     * Saves address fields to .data() for comparing purposes
     * @param  {jQuery} $form             - Base form.
     * @return {Object.<string, string>}  - Address object saved to .data(). See documentation above.
     */
    saveAddressData: function($form) {
      var address  = {};
      $form.find(shipping.addressFieldsSelector).each(function() {
        address[$(this).data('shipping-address')] = $(this).val();
      });
      $form.data('shipping-address', address);
      return address;
    },

    /**
     * Checks if current address differs from address saved in .data()
     * @param  {jQuery} $form - Base form.
     * @return {boolean}      - True if a field has changed. False otherwise.
     */
    didAddressChange: function($form) {
      var changed = false;

      $form.find(shipping.addressFieldsSelector).each(function() {
        var key       = $(this).data('shipping-address');
        var oldValue  = $form.data('shipping-address')[key] || '';
        var newValue  = $(this).val();
        if (newValue !== oldValue) {
          changed = true;
          return;
        }
      });
      return changed;
    },

    /**
     * Recalculates costs based on new newShippingCost, saves them to .data('shipping-cost') and returns them
     * @param  {jQuery}        $form            - Base form.
     * @param  {string,number} newShippingCost  - New shipping cost
     * @return {Object.<string, number>}        - Updated costs saved to .data(). See documentation above.
     */
    setCosts: function($form, newShippingCost) {

      var cost = {};

      // Shipping
      cost.shipping = parseCurrency(newShippingCost.toString());

      // Subtotal
      var $subtotal = $form.find(shipping.subtotalFieldSelector);
      var method    = !$subtotal.is(':input') || $subtotal.is('button') ? 'html' : 'val';
      cost.subtotal = parseCurrency($subtotal[method]());

      // Total
      cost.total    = cost.subtotal + cost.shipping;

      // Save
      $form.data('shipping-cost', cost);

      return cost;

    },

    /**
     * Calls jquery.loadingdots on the dynamic fields
     * @param  {jQuery} $form - Base form.
     * @param  {string} [key] - Method to call on .loadingdots(key) to control dots.
     * @return {jQuery}       - jQuery Object with dynamic fields.
     */
    loadingDynamicFields: function($form, key) {
      return $form.find(shipping.dynamicFieldsSelector).loadingdots(key);
    },

    /**
     * Updated the dynamic fields with the calculated costs
     * @param  {jQuery} $form - Base form
     * @return {jQuery}       - jQuery object with dynamic fields
     */
    updateDynamicFields: function($form) {
      $form
        .find(shipping.dynamicFieldsSelector)
        .loadingdots('stop')
        .each(function() {
          var $element = $(this);
          var method   = !$element.is(':input') || $element.is('button') ? 'html' : 'val';
          var key      = $element.data('shipping-cost');
          var value    = $form.data('shipping-cost')[key];
          $element[method](prefixCurrency(value));
        })
        .animatecss(shipping.costUpdateAnimation);
    },

    /**
     * Fetches shipping cost for the address in the form
     * @param  {jQuery}   $form     - Base Form
     * @param  {Function} callback  - Handler for AJAX response.
     * @return {jqXHR}              - jQuery XHR object
     */
    requestCostForAddress: function($form, callback) {
      var params  = {};
      $form.find(shipping.addressFieldsSelector).each(function() {
        var key = $(this).data('shipping-address');
        if (key === 'country')  { params[key] = $(this).find(':selected').first().text(); }
        else                    { params[key] = $(this).val(); }
      });
      return $.getEstimatedShippingCost(params, callback);
    },

    /**
     * Enable or disable the form
     * @param  {jQuery}   $form           - Base form
     * @param  {boolean}  enableOrDisable - Boolean indicating whether to enable or disable the form
     * @return {jQuery}                   - Base form
     */
    toggleForm: function($form, enableOrDisable) {
      if (enableOrDisable === false) {
        $form.disableFormElementsWith(shipping.buttonProcessingMessage);
      }
      else {
        $.rails.enableFormElements($form);
      }
      return $form;
    },

    /**
     * Fetch, store, and refresh the cost for an address
     * @param  {jQuery}   $form           - Base form
     * @param  {Function} onAfterCallback - Callback called after updating the form
     * @return {jqXHR}                    - jQuery XHR object
     */
    updateCostForAddress: function($form, onAfterCallback) {

      // Disable the form
      shipping.toggleForm($form, false);

      // Set loading dots on the fields
      shipping.loadingDynamicFields($form);

      // Get cost from server
      return shipping.requestCostForAddress($form, function(data) {

        if (data.status !== 'ok') {
          console.log("UH-OH!");
          console.log(data);
          shipping.toggleForm($form, true);
          return false;
        }

        shipping.setCosts($form, data.response.cost);
        shipping.updateDynamicFields($form);
        shipping.toggleForm($form, true);

        // Call optional callback
        if (_.isFunction(onAfterCallback)) { onAfterCallback($form); }

      });
    }


  };

}(jQuery));