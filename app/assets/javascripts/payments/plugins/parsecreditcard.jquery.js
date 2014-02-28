/**
 * Parses credit card form fields and returns an Stripe-compatible object
 * This is required to deal with unified (month + year) expiration date fields
 */
(function($) {

  $.fn.parseCreditCard = function() {

    var $this   = $(this);
    var $number = $this.find('.cc-number');
    var $cvc    = $this.find('.cc-csc');
    var $exp    = $this.find('.cc-exp');
    var exp     = $.payment.cardExpiryVal($exp.val());

    var stripeData = {
      number:     $number.val().replace(/\s+/g, ''),
      cvc:        $cvc.val().replace(/\s+/g, ''),
      exp_month:  exp.month,
      exp_year:   exp.year
    };

    return stripeData;
  }

}(jQuery));