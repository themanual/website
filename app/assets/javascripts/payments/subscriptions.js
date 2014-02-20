$(function() {

  // Stripe Forms
  $('.stripe-form').each(function() {

    var $form = $(this);

    // Response handler
    var stripeResponseHandler = function(status, response) {

      var $this = $(this); // 'this' is the form, as set by _.bind

      if (response.error) {
        // TODO show something to the user, form is not submitted
      } else {
        $this.find('[name=stripe_token]').val(response.id);
        $this.get(0).submit();
      }
    };

    // Important! Validation plugin must come before submit.
    $form.validate().submit(function(event) {
      event.preventDefault();
      event.stopPropagation()
      Stripe.card.createToken($(this).parseCreditCard(), _.bind(stripeResponseHandler, this));
      return false;
    });

  });

});