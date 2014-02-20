(function($) {

  $.validate = {
    CLASSES:          { valid: 'is-valid', invalid: 'is-invalid'},
    PAYMENT_CLASSES:  ['cc-number', 'cc-csc', 'cc-exp'],
    IGNORED_FIELDS:   ['[type=hidden]', 'button', '[type=submit]'],
    SPECIAL_TYPES:    { check: 'checkbox', radio: 'radio' },
    HTML_INPUT_TYPES: ['email', 'number'],
    PATTERNS:  {
      email:    /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i,
      number:   /^\d+([,.]\d+)?$/,
      required: /\S+/
    }
  };

  $.fn.validateField = function(callback) {

    // Shorthands
    var $field = $(this);
    var type          = $field.attr('type');
    var required      = $field.attr('required');
    var pattern       = $field.attr('pattern');
    var value         = $field.val().replace(/(^\s+|\s+$)/g,'');

    // Validation results
    var results   = {};
    var valid     = true;

    // Test for special type
    var isSpecialType = (_.indexOf(_.values($.validate.SPECIAL_TYPES), type) >= 0);
    // Test for payment
    var paymentFieldClasses = _.intersection($field.classArray(), $.validate.PAYMENT_CLASSES);
    var isPaymentField = (paymentFieldClasses.length > 0);

    if (isPaymentField) { // It's a payment field
      var paymentFieldClass = paymentFieldClasses[0];
      // set validation results
      switch (paymentFieldClass) {
        case 'cc-number':
          results[paymentFieldClass] = $.payment.validateCardNumber($field.val());
          break;
        case 'cc-csc':
          results[paymentFieldClass] = $.payment.validateCardCVC($field.val());
          break;
        case 'cc-exp':
          var exp = $.payment.cardExpiryVal($field.val());
          results[paymentFieldClass] = $.payment.validateCardExpiry(exp.month, exp.year);
          break;
      }

      // set valid flag
      if (results[paymentFieldClass] !== null) {
        valid &= results[paymentFieldClass];
      }

    }
    else if (isSpecialType && required) { // If it's a non-payment field of a special type
      var checked = $field.is(':checked');
      switch(type) {
        case $.validate.SPECIAL_TYPES.check:
          results.required = checked;
          valid &= results.required;
          break;
        case $.validate.SPECIAL_TYPES.radio:
          break;
      }
    }
    else { // If it's a regular, non-payment, non-special field

      // validate standard HTML 'type' attributes
      if (type && _.indexOf($.validate.HTML_INPUT_TYPES, type) >= 0 && $.validate.PATTERNS[type]) {
        results.type = $.validate.PATTERNS[type].test(value);
        valid &= results.type;
      }

      // validate 'required' attribute
      if (required) {
        results.required = $.validate.PATTERNS['required'].test(value);
        valid &= results.required;
      }

      // validate 'pattern' attribute
      if (pattern) {
        results.pattern = $.validate.PATTERNS[pattern].test(value);
        valid &= results.pattern;
      }

    }


    // Apply classes to field
    $field
      .removeClass(_.values($.validate.CLASSES).join(' '))
      .addClass(valid ? $.validate.CLASSES.valid : $.validate.CLASSES.invalid);

    // Run callback
    if (_.isFunction(callback)) {
      callback(valid, results);
    }

    return valid;
  };

  $.fn.validateForm = function(callback) {
    var $form = $(this);
    var $inputs = $form.find(':input').not($.validate.IGNORED_FIELDS.join(','));

    var valid   = true;
    var results = $inputs.map(function(index) {
      var result = $(this).validateField();
      valid &= result;
      return result;
    });

    if (_.isFunction(callback)) {
      callback(valid, results);
    }

    return valid;
  };

  // Validate form
  $.fn.validate = function() {

    return this.each(function() {

      var bindHandlers = _.once(function($form){
        $form
          .find(':input').not($.validate.IGNORED_FIELDS.join(','))
          .on('focusout focusin change keyup', function() { $(this).validateField(); });
      });

      $(this).submit(function(event) {
        var $form = $(this);
        var $submit_button  = $form.find('*[type=submit]');

        // Disable the submit button to prevent repeated clicks
        $submit_button.prop('disabled', true);

        var valid = $form.validateForm();

        if (!valid) {
          // Prevent further submit handlers
          event.stopImmediatePropagation();
          bindHandlers($form);
          $submit_button.prop('disabled', false).animate('shake');
        }

        return false;

      });

    });
  }

}(jQuery));