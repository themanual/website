$(function() {

  $(".header-nav-menu > li.has-dropdown > a").click(function() {
    $(this).parent().toggleClass("is-expanded");
    return false;
  });

  // Don't follow # hrefs
  $("a[href='#']").click(function(event) {
    return false;
  });

  // fitvids
  $(".video").fitVids();

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
