$(function() {

  $("window").load(function() {
    $("body").removeClass("preload");
  });

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

});