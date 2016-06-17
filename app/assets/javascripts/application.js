// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap-sprockets
//= require flat-ui
//= require flat-ui/flatui-checkbox
//= require flat-ui/flatui-radio

$(document).ready(function() {
  // Hide messages after 5s
	setTimeout(
    function() {
     $(".alert").fadeOut();
    },
    5000
  );

  // Fix Flat UI Radio
  var tmp = $(".radio").find("label");
  if (tmp.length) {
    if ($(".gender").data("id")) {
    	tmp[1].click();
    	tmp[0].click();
    } else {
    	tmp[0].click();
    	tmp[1].click();
    }

    $(".radio label").css("margin-top", "-8px");
  };

  // Create Tooltips
  $('[data-toggle="tooltip"]').tooltip(); 
});