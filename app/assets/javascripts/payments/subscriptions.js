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

    $form.submit(function(event) {
      
      var $this           = $(this),
          $submit_button  = $('*[type=submit]');
      event.preventDefault();
      event.stopPropagation();

      // Disable the submit button to prevent repeated clicks
      $submit_button.prop('disabled', true);

      // If passes client-side validation, submit.
      // If it doesn’t, re-enable the form button
      if ($this.validateCreditCard()) {
        Stripe.card.createToken($this.parseCreditCard(), stripeHandler);
      }
      else {
        $submit_button.prop('disabled', false);
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