$(function() {

  $('form').validate();
  $('.payment-form').stripe();

  // pre-fill country selector with country via geoip lookup
  $.getEstimatedShippingCost({}, function(data){
    if (data.status == 'ok' && data.response.ip_country) {
      var id = $('option[data-code=' + data.response.ip_country +']').attr('value');

      $('option[data-code]:first').closest('select').val(id);
    }
  });

});
