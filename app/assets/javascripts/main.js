// Google Analytics
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments);},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m);
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create', 'UA-46481984-1', 'auto');
ga('send', 'pageview');

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