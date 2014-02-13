$(function() {


  // Stripe Forms
  $('.stripe-form').each(function() {

    $form = $(this);

    $('input.cc-number').payment('formatCardNumber');
    $('input.cc-exp').payment('formatCardExpiry');
    $('input.cc-csc').payment('formatCardCVC');

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
      
      event.preventDefault();
      event.stopPropagation();

      $this = $(this);

      // Disable the submit button to prevent repeated clicks
      $this.find('button').prop('disabled', true);

      // Submit
      // TODO split the single expiration field into the two parts
      Stripe.card.createToken($this, stripeHandler);

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