var prefixCurrency = window.prefixCurrency = function(currencyNumber) {
  // convert to number if needed
  if (typeof currencyNumber === 'string') { currencyNumber = parseCurrency(currencyNumber); }
  // round
  var value = currencyNumber.toString().replace(/\.\d$/g, '$&0');
  // HTML
  return '<span class="currency">$</span><span class="value">' + value + '</span>';
}