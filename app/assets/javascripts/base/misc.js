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

  $('select.chosen').chosen();

  $('.support-tier button[data-value]').click(function() {
    var $button = $(this);
    var $form   = $('.payment-form');
    if (!$form.is(':visible')) {
      $form.slideDown().animatecss('fadeInDown');
    }
  });

});