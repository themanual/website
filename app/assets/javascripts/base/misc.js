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
    $(this).closest('.support-tier').addClass('is-selected').siblings().removeClass('is-selected');
    if (!$form.is(':visible')) { $form.slideDown(500).animatecss('fadeInDown'); }
    window.setTimeout(function() { $.scrollTo($form, { duration: 500, easing: 'easeInOutQuart'}); }, 150);
  });

});