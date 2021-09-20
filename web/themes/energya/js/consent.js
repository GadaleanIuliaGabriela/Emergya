(function($){
  $(window).on('cookiebotConsentRenew', function(event){
    $("html, body").animate({scrollTop: $('#cookiesjsr').offset().top});
  });
  $(document).on('cookiesjsrCallbackResponse', function (event) {
      location.reload();
  })


})(jQuery)
