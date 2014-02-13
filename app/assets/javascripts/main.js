$(function() {

  // Support slider
  $(".support-slider").noUiSlider({
    range: [1, 100],
    start: 1,
    step:  1,
    handles: 1,
    serialization: {
      to: $("#support-panel-form-price"),
      resolution: 1
    }
  });

});