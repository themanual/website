(function($) {


  // Client-side Payment Form Validation
  $.fn.validateCreditCard = function() {

    var $this = $(this);

    // Form fields
    var $number = $this.find('.cc-number'),
        $cvc    = $this.find('.cc-csc'),
        $exp    = $this.find('.cc-exp');

    var valid = true;

    // Card Number
    if (!$.payment.validateCardNumber($number.val())) { 
      valid = false; 
      $number.addClass('is-error');
    }
    // CVC
    if (!$.payment.validateCardCVC($cvc.val())) {
      valid = false;
      $cvc.addClass('is-error');
    }

    // Expiration Date (needs processing first)
    var exp = $.payment.cardExpiryVal($exp.val());
    if (!$.payment.validateCardExpiry(exp.month, exp.year)) {
      valid = false;
      $exp.addClass('is-error');
    }

    return valid;

  }

  $.fn.parseCreditCard = function() {
    // Stored for optimization
    var $this = $(this);

    // Form fields
    var $number = $this.find('.cc-number'),
        $cvc    = $this.find('.cc-csc'),
        $exp    = $this.find('.cc-exp');

    var exp = $.payment.cardExpiryVal($exp.val());

    var stripe_data = {
      number:     $number.val().replace(/\s+/g, ''),
      cvc:        $cvc.val().replace(/\s+/g, ''),
      exp_month:  exp.month,
      exp_year:   exp.year
    };

    return stripe_data;
  }

}(jQuery));