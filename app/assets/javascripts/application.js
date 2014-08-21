//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require tinymce-jquery
//= require hashchange
//= require modernizr
//= require slicknav
//= require foundation
//= require_tree .

$(document).foundation();

function resetScroll() {
  $('.search').css("width","100%");
  $('#hdr-logo').css("position","relative");
  $('#hdr-logo').css("top","0");
  $('#hdr-logo').css("left","0");
  $('.inner-content').css("padding-top","0px");
  $('.page-splash').css("position","relative");
  $('.page-splash').css("top", "0");
}

function setScroll() {
  $('.search').css("width","60%");
  $('.page-splash').css("position","fixed");
  $('#hdr-logo').css("position","absolute");
  $('#hdr-logo').css("top","70px");
  $('#hdr-logo').css("left","20px");
  $('.page-splash').css("top", "-65px");
  $('.inner-content').css("padding-top","146px");
}

function checkScroll() {
  var scroll = $(window).scrollTop();
  if (scroll >= 64) {
    setScroll();
  } else {
    resetScroll();
  }
}

$(document).on("ready page:load", function(){
  $(window).scroll(function (event) {
    if (window.innerWidth > 641) {
      checkScroll();
    } else {
      resetScroll();
    }
  });

  $( window ).resize(function() {
     if (window.innerWidth <= 641) {
      resetScroll();
     } else {
      checkScroll();
     }
  });
});
