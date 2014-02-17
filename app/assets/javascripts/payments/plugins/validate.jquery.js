(function($) {

  $.validate = {
    CLASSES:              { valid: 'is-valid', invalid: 'is-invalid'},
    CC_FIELDS:            ['.cc-number', '.cc-csc', '.cc-exp'],
    IGNORED_FIELDS:       ['[type=hidden]', 'button', '[type=submit]'],
    HTML_INPUT_TYPES:     ['email', 'number'],
    PATTERNS:  {
      email:    /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i,
      number:   /^\d+([,.]\d+)?$/,
      required: /\S+/
    }
  };

  // Valid Field
  $.fn.validateField = function(callback) {

    var $field = $(this);

    // attributes and value
    var type      = $field.attr('type');
    var required  = $field.attr('required');
    var pattern   = $field.attr('pattern');
    var value     = $field.val().replace(/(^\s+|\s+$)/g,'');

    // storing validation tests
    var results   = {};
    var valid     = true;

    // validate standard HTML 'type' attributes
    if (type && _.indexOf($.validate.HTML_INPUT_TYPES, type) >= 0 && $.validate.PATTERNS[type]) {
      results.type = $.validate.PATTERNS[type].test(value);
      valid &= results.type;
    }

    // validate 'required' attribute
    if (required) {
      results.required = $.validate.PATTERNS.required.test(value);
      valid &= results.required;
    }

    // validate 'pattern' attribute
    if (pattern) {
      results.pattern = $.validate.PATTERNS[pattern].test(value);
      valid &= results.pattern;
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
    var $inputs = $form
        .find(':input')
        .not($.validate.IGNORED_FIELDS.join(','))
        .not($.validate.CC_FIELDS.join(','));

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

      $(this).submit(function() {
        // store form
        var $form = $(this);
        // Disable the submit button to prevent repeated clicks
        var $submit_button  = $form.find('*[type=submit]');
        $submit_button.prop('disabled', true);

        var valid = $form.validateForm();

        if (!valid) {
          event.stopImmediatePropagation();
          $submit_button
            .prop('disabled', false)
            .animate('shake');
          return false;
        }

      });

    });
  }

}(jQuery));