$(document).on "ready page:load", ->
  $("pre").each (index, element) ->
    buttonId = "code-#{index}"
    $(element).wrap( "<div id='#{buttonId}' class='col-sm-12 left clearfix'></div>" ); # Wrap in Div Element
    $("##{buttonId}").before(button(index)) # Before the div element, add a button
    $(element).attr("id", "pre-" + index) # Make the pre element have an id
  clip = new ZeroClipboard($(".copy-button"))
  clip.addEventListener "complete", (client, text) ->
    Toast.toastMessage "Successfully Copied The Code!"
    Toast.processToast()

button = (id) ->
  buttonEl = "<div class='col-sm-12'>"
  buttonEl = buttonEl + "<button class='button small copy-button right clearfix' data-clipboard-target='pre-#{id}' title='Click me to copy the code.'>"
  buttonEl = buttonEl + "<b>Copy The Code</b>"
  buttonEl = buttonEl + "</button></div>"
  buttonEl
