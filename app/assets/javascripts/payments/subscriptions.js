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

  $.fn.slider = function(sliderOptions) {
    return this.each(function() {
      var min = sliderOptions.range[0];
      var max = sliderOptions.range[sliderOptions.range.length - 1];

      // enable slider
      $(this).find(".support-slider-control").noUiSlider(sliderOptions);

      //
      $(this).find(".support-slider-legend [data-legend-value]")
        .each(function() {
          var value = $(this).data('legend-value');
          var percentage = ((value - min)  / (max - min) * 100) + "%";
          $(this).css({left: percentage});
        })
        .click(function() {
          $(".support-slider-control").val($(this).data('legend-value'), true);
        });
    });
  };

  $(".support-slider").slider({
    range: [1, 60],
    start: 20,
    step:  1,
    handles: 1
  });

});