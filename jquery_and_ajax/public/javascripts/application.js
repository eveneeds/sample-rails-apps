/*
 This app is consequently using $ to refer to jQuery. More info here: http://docs.jquery.com/Using_jQuery_with_Other_Libraries
*/

// Hooking jQuery up with Rails' respond_to (http://ozmm.org/posts/jquery_and_respond_to.html)
$.ajaxSetup({ 
  beforeSend: function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

// All will_paginate entities in the DOM gets ajaxified with livequery (http://ozmm.org/posts/ajax_will_paginate_jq_style.html)
$(function(){
  $('div.pagination a').livequery('click', function() {
    $('#main').load(this.href);
    return false;
  });
})