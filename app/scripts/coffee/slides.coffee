slideNumber = 1
slide = null
view = new kendo.View "<div>"
effectsQueue = []
reset = {}
paused = false

# get a list of all the slides divs
slides = $(".slide")
totalSlides = slides.length

# attach listeners to left/right arrows
$(document).keydown (e) ->
  if not paused
    if e.keyCode == 37
      previous()
      return false
    if e.keyCode == 39
      next()
      return false

# subscribe to events
$.subscribe "/slides/show", (e, index) ->
  show index

# queue up effects for all slides
queueEffects = (element) ->
  effectsQueue = element.find "[data-effect]"

show = (index) ->

  # if the index is beyond the range - punt
  if index < 1 or index > totalSlides
    return false

  previousSlide = slide
  slide = $(slides[index - 1])

  effectsQueue = slide.find "[data-effect]"

  # if we are coming from a previous slide
  if previousSlide
    if slide.data "transition"
      kendo.fx(previousSlide).fade("in").stop().duration(500).reverse().then ->
        slide.show()
        fit slide
        kendo.fx(slide).fade("in").duration(500).stop().play().then
    else
      previousSlide.hide()
      slide.show()
    
  else
    slide.show()

  fit slide

  # setup effects
  $.publish "/effects/setup", [ slide ]

  # increment the slide number
  slideNumber = index

  # fire the show event
  event = slide.find "[data-show]"
  event.each ->
    events[event.data "show"](@)

fit = (el) ->
  # apply fit text to any fit elements
  el = $(el).find ".fit"
  size = el.data "fit"
  
  el.fitText size

  $(el).find(".fit-large").fitText(.2)

previous = ->
  $.publish "/effects/reset"
  slideNumber -= 1
  $.publish "/router/navigate", [ "/slides/#{slideNumber}" ]

next = ->
  if effectsQueue.length > 0
    $.publish "/effects/process", [ effectsQueue[0] ]

  else
    slideNumber += 1
    $.publish "/router/navigate", [ "/slides/#{slideNumber}" ]

$.subscribe "/effects/done", ->
  effectsQueue.splice 0,1

# bind the document to a view model to handel events
bootstrap = true

viewModel = kendo.observable {
  toggleBootstrap: ->
    $bootstrap = $("#bootstrap")
    if bootstrap
      $bootstrap.attr "rel", "notastylesheet"
      bootstrap = false
    else
      $bootstrap.attr "rel", "stylesheet"
      bootstrap = true
  pauseControls: ->
    paused = true
  unpauseControls: ->
    paused = false
    @set "editorVisible", false
  updateSampleQuery: (e) ->
    style = $("#scoped-sample-query")
    style.html $(e.currentTarget).text()
    paused = false
  screenSize: $(window).width()
  updateHtml: (e) ->
    setTimeout ->
      source = $(e.currentTarget)
      target = slide.find(source.data "target")
      if target.length > 0
        slide.find(target).html source.text()
      else
        source.next().html source.text()
    , 100
  containerWidth: 0
  containerPadding: 0
  containerMargin: 0
  editorVisible: false
  showEditor: ->
    visible = @get "editorVisible"
    if visible
      @set "editorVisible", false
    else 
      @set "editorVisible", true
}

kendo.bind "body", viewModel

# attach an event listener to the window resize method to update the screen size
$(window).resize ->
  viewModel.set "screenSize", $(this).width()
  viewModel.set "containerWidth", $(".container-demo").width()

events = {
  setContainerSize: (el) ->
    $el = $(el)
    viewModel.set "containerWidth", $el.width()
    viewModel.set "containerPadding", $el.css "padding"
    viewModel.set "containerMargin", $el.css "margin"
}

