/**
 * Prettifies payment forms using $.payment
 */
(function($) {

  var creditCardSelectors = {
    num: [
      'input.cc-number',
      '[data-stripe=number]',
      '[autocompletetype=cc-number]'],
    exp: [
      'input.cc-exp',
      '[autocompletetype=cc-exp]'],
    csc: [
      'input.cc-csc',
      'input.cc-cvc',
      '[data-stripe=cvc]',
      '[autocompletetype=cc-csc]']
  };

  $.fn.prettifyPaymentForm = function() {
    return this.each(function() {
      var $this = $(this);
      $this.find(creditCardSelectors.num.join(",")).payment('formatCardNumber');
      $this.find(creditCardSelectors.exp.join(",")).payment('formatCardExpiry');
      $this.find(creditCardSelectors.csc.join(",")).payment('formatCardCVC');
    });
  }

}(jQuery));