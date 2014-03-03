var parseCurrency = window.parseCurrency = function(currencyString) {
  return parseFloat(currencyString.replace(/[^0-9\.]+/g,""));
}