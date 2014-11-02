//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require tinymce-jquery
//= require hashchange
//= require modernizr
//= require slicknav
//= require foundation
//= require highlight.pack
//= require analytics
//= require zeroclipboard
//= require_tree .

resetScroll = ->
  if window.fixed_header
    window.fixed_header = false
    $(".search").animate
      width: "100%"
    ,
      queue: false
      duration: 250

    $("#hdr-logo").css "position", "relative"
    $("#hdr-logo").css "top", "0"
    $("#hdr-logo").css "left", "0"
    $(".inner-content").css "padding-top", "0px"
    $(".page-splash").css "position", "relative"
    $(".page-splash").css "top", "0"

setScroll = ->
  unless window.fixed_header
    window.fixed_header = true
    $(".search").animate
      width: "60%"
    ,
      queue: false
      duration: 250

    $(".page-splash").css "position", "fixed"
    $("#hdr-logo").css "position", "absolute"
    $("#hdr-logo").css "top", "70px"
    $("#hdr-logo").css "left", "20px"
    $(".page-splash").css "top", "-65px"
    $(".inner-content").css "padding-top", "146px"

checkScroll = ->
  scroll = $(window).scrollTop()
  if scroll >= 64
    setScroll()
  else
    resetScroll()

$(document).foundation()
window.fixed_header = false

$(document).on "ready page:load", ->

  $("pre").each (i, block) ->
    hljs.highlightBlock block

  $(window).scroll (event) ->
    if window.innerWidth > 641
      checkScroll()
    else
      resetScroll()

  $(window).resize ->
    if window.innerWidth <= 641
      resetScroll()
    else
      checkScroll()

