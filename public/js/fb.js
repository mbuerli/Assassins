// Additional JS functions here
window.fbAsyncInit = function() {
  FB.init({
    appId      : '566636903353910', // App ID
    channelUrl : 'http://acm.calpoly.edu/assassins/channel.html', // Channel File
    status     : true, // check login status
    cookie     : true, // enable cookies to allow the server to access the session
    xfbml      : true  // parse XFBML
  });

  FB.Event.subscribe('auth.login', function(response) {
    // We want to reload the page now so PHP can read the cookie that the
    // Javascript SDK sat. But we don't want to use
    // window.location.reload() because if this is in a canvas there was a
    // post made to this page and a reload will trigger a message to the
    // user asking if they want to send data again.
    window.location = window.location;
  });

};

// Load the SDK Asynchronously
(function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/en_US/all.js";
   ref.parentNode.insertBefore(js, ref);
 }(document));