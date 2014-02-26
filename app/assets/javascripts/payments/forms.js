$(function() {

  var CreditCardSelectors = {
    num: [
      'input.cc-number',
      '[data-stripe=number]',
      '[autocompletetype=cc-number]']
    exp: [
      'input.cc-exp',
      '[autocompletetype=cc-exp]']
    csc: [
      'input.cc-csc',
      'input.cc-cvc',
      '[data-stripe=cvc]',
      '[autocompletetype=cc-csc]']
  };

  $(CreditCardSelectors.num.join(",")).payment('formatCardNumber');
  $(CreditCardSelectors.exp.join(",")).payment('formatCardExpiry');
  $(CreditCardSelectors.csc.join(",")).payment('formatCardCVC');

});