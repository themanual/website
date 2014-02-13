$(function() {

	var $form;

	var handler = function(status, response) {
		if (response.error) {
			// TODO show something to the user, form is not submitted
		} else {
			$form.find('[name=stripe_token]').val(response.id);
			$form.get(0).submit();
		}
	};

	$('form.stripe-form').submit(function(event) {
		event.preventDefault();
    $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true);

    Stripe.card.createToken($form, handler);

  });

  // Support slider
  $(".support-slider").noUiSlider({
    range: [1, 100],
    start: 1,
    step:  1,
    handles: 1
  });
  
});