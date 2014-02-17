$(function() {

  // Stripe Forms
  $('.stripe-form').each(function() {

    var $form = $(this);

    // Response handler
    var stripeHandler = function(status, response) {
      if (response.error) {
        // TODO show something to the user, form is not submitted
      } else {
        $form.find('[name=stripe_token]').val(response.id);
        $form.get(0).submit();
      }
    };

    $form.validate();

    $form.submit(function(event) {

      var $this           = $(this);

      event.preventDefault();
      event.stopPropagation()

      if ($this.validateCreditCard()) {
        // TODO Change button name
        Stripe.card.createToken($this.parseCreditCard(), stripeHandler);
      }

      return false;
    });

  });

  // Support slider
  $(".support-slider").noUiSlider({
    range: [1, 100],
    start: 1,
    step:  1,
    handles: 1
  });

});