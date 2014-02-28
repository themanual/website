/**
 * Handles submit events for Stripe forms
 * 1. Parses a credit card form, using $.fn.parseCreditCard
 * 2. Creates the Stripe token, using Stripe.card.createToken
 * 3. Injects the token in the form and submits again
 */
(function($) {

  $.fn.stripe = function() {

    return this.each(function() {

      $(this).submit(function(event) {

        event.preventDefault();

        var $form = $(this);
        var creditCardData = $form.parseCreditCard();

        Stripe.card.createToken(creditCardData, function(status, response) {
          if (response.error) {
            // TODO show something to the user, form is not submitted
          } else {
            $form.find('[name=stripe_token]').val(response.id);
            $form.get(0).submit();
          }
        });

        return false;

      });

    });

  };

}(jQuery));