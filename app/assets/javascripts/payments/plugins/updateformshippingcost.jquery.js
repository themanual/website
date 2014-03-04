(function($) {

  /**
   * Updates the shipping cost and total for any shipment form
   * @param  {Function} [callback(data, cost)] - Function called after data has been updated. Optional.
   * @return {jQuery}
   */
  $.fn.updateFormShippingCost = function(callback) {
    return this.each(function() {

      var $form = $(this);
      var UPDATE_ANIMATION = 'flash';

      var $elements = {
        subtotal: $form.find('[data-shipping-cost="subtotal"]'),
        shipping: $form.find('[data-shipping-cost="shipping"]'),
        total:    $form.find('[data-shipping-cost="total"]')
      };

      $elements.shipping.empty().loadingdots({word: 'Loading'});
      $elements.total.empty().loadingdots({word: 'Loading'});

      $(this).getFormShippingCost(function(data){

        if (data.status !== 'ok') {
          console.log("UH-OH!");
          console.log(data);
          return false;
        }

        // Get Costs
        var cost = {};
        cost.shipping = parseCurrency(data.response.cost);
        cost.subtotal = parseCurrency($elements.subtotal.text());
        cost.total    = Number((cost.subtotal + cost.shipping).toFixed(2));

        // Update DOM
        $elements.shipping.loadingdots('stop').html(prefixCurrency(cost.shipping)).animateCss(UPDATE_ANIMATION);
        $elements.total.loadingdots('stop').html(prefixCurrency(cost.total)).animateCss(UPDATE_ANIMATION);

        if (_.isFunction(callback)) {
          callback(data, cost, $elements);
        }
      });

    });
  };

}(jQuery));