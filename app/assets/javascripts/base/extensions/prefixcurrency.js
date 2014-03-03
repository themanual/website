var prefixCurrency = window.prefixCurrency = function(currencyNumber) {
  var PREFIX = '<span class="currency">$</span>';

  if (typeof currencyNumber === 'number') {
    return PREFIX + currencyNumber.toString().replace(/\.\d$/g, '$&0');
  }
  else if (typeof currencyNumber === 'string') {
    return PREFIX + parseCurrency(currencyNumber).toString().replace(/\.\d$/g, '$&0');
  }
  else {
    return currencyNumber;
  }
}