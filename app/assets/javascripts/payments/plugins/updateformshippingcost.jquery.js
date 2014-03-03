(function($) {

  $.fn.updateFormShippingCost = function(callback) {
    return this.each(function() {

      var $form = $(this);

      var $elements = {
        subtotal: $form.find('[data-shipping-cost="subtotal"]'),
        shipping: $form.find('[data-shipping-cost="shipping"]'),
        total:    $form.find('[data-shipping-cost="total"]')
      };

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
        cost.total    = cost.subtotal + cost.shipping;

        // Update DOM
        $elements.shipping.html(prefixCurrency(cost.shipping)).animateCss('flash');
        $elements.total.html(prefixCurrency(cost.total)).animateCss('flash');
      });

    });
  };

}(jQuery));