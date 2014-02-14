(function($) {
  
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