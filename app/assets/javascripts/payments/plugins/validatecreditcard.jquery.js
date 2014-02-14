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
  
}(jQuery));