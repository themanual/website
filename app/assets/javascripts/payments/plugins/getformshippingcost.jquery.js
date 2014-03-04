(function($) {

  /**
   * Parses any shipment form, prepping the params for $.getEstimatedShippingCost and calling it
   * @param  {Function} callback - Callback passed to $.getEstimateShippingCost
   * @return {jQuery}
   */
  $.fn.getFormShippingCost = function(callback) {
    return this.each(function() {
      var $form   = $(this);
      var params  = {};
      var ADDRESS_KEY = 'data-shipping-address';
      $form.find('['+ADDRESS_KEY+']').each(function(index, el) {
        if ($(this).attr(ADDRESS_KEY) === 'country') {
          params[$(this).attr(ADDRESS_KEY)] = $(this).find(':selected').first().text();
        }
        else {
          params[$(this).attr(ADDRESS_KEY)] = $(this).val();
        }
      });
      $.getEstimatedShippingCost(params, callback);
    });
  };

}(jQuery));