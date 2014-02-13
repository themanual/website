$(function() {

	var handler = function(status, response) {

	};

	$('form.stripe-form').submit(function(event) {
    var $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true);

    Stripe.card.createToken($form, handler);

    // Prevent the form from submitting with the default action
    return false;
  });
});