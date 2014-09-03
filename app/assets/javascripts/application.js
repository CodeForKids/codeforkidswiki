//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require tinymce-jquery
//= require hashchange
//= require modernizr
//= require slicknav
//= require foundation
//= require highlight.pack
//= require_tree .

$(document).foundation();

window.fixed_header = false;

function resetScroll() {
  if (window.fixed_header) {
    window.fixed_header = false;
    $('.search').animate({width:"100%"},{queue:false,duration:250});
    $('#hdr-logo').css("position","relative");
    $('#hdr-logo').css("top","0");
    $('#hdr-logo').css("left","0");
    $('.inner-content').css("padding-top","0px");
    $('.page-splash').css("position","relative");
    $('.page-splash').css("top", "0");
  }
}

function setScroll() {
  if (!window.fixed_header) {
    window.fixed_header = true;
    $('.search').animate({width:"60%"},{queue:false,duration:250});
    $('.page-splash').css("position","fixed");
    $('#hdr-logo').css("position","absolute");
    $('#hdr-logo').css("top","70px");
    $('#hdr-logo').css("left","20px");
    $('.page-splash').css("top", "-65px");
    $('.inner-content').css("padding-top","146px");
  }
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

  if (window._gaq != null) {
    _gaq.push(['_trackPageview']);
  } else if (window.pageTracker != null) {
    pageTracker._trackPageview();
  }

  $(document).ready(function() {
    $('pre').each(function(i, block) {
      hljs.highlightBlock(block);
    });
  });

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
