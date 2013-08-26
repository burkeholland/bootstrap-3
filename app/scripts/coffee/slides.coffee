slideNumber = 1
nextSlide = 2
effectsQueue = []
paused = false

# make the whole document surface touchable
$(".slide").kendoTouch {
  surface: $(".slide"),
  enableSwipe: true,
  swipe: (e) ->
    if e.direction == "left" then next()
    if e.direction == "right" then previous()
}

previous = ->
  nextSlide = slideNumber - 1
  if nextSlide > 0
    app.navigate "#slide#{nextSlide}"
    slideNumber = nextSlide

next = ->
  nextSlide = slideNumber + 1
  if nextSlide <= idCounter
    if effectsQueue.length > 0
      $.publish "/effects/process", [ effectsQueue[0] ]
    else
      app.navigate "#slide#{nextSlide}"
      slideNumber = nextSlide

# attach listeners to left/right arrows
$(document).keydown (e) ->
  if e.keyCode == 9
    paused = false
  if not paused
    if e.keyCode == 37
      previous()
      return false
    if e.keyCode == 39
      next()
      return false

$.subscribe "/effects/done", ->
  effectsQueue.splice 0,1

$.subscribe "/controls/paused", (e, flag) ->
  paused = flag

window.APP.slides.init = (e) ->
  # set the slide number
  slideNumber = parseInt @.element.data "slide"

window.APP.slides.show = (e) ->
  $slide = e.view.element

  # apply fit text to any elements
  fit = $slide.find(".fit").each ->
    $(@).fitText $(@).data("fit") || 1

  # apply fitvids to any video containers
  $slide.find(".fitvids").fitVids()
  
  # track the effects
  effectsQueue = $slide.find "[data-effect]"

  # setup the effects for this slide
  $.publish "/effects/setup", [ $slide ]

idCounter = 1
$("[data-role='view']").each ->
  $that = $ @
  $that.attr "id", "slide#{idCounter}"
  $that.attr "data-slide", idCounter
  $that.attr "data-init", "APP.slides.init"
  $that.attr "data-show", "APP.slides.show"
  $that.attr "data-layout", "slideDeck"
  $that.attr "data-stretch", "true"
  idCounter++

app = new kendo.mobile.Application document.body, { initial: "slide1", transition: "fade", webAppCapable: true }

# override Kendo UI Mobile busting anchors
$("a").on "click",  (e) ->
  document.location = e.currentTarget.href



