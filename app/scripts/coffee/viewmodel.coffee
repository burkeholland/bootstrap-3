paused = (flag) ->
  $.publish "/controls/paused", [ flag ]

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
    paused(true)
  unpauseControls: ->
    paused(false)
    @set "editorVisible", false
  updateSampleQuery: (e) ->
    style = $("#scoped-sample-query")
    style.html $(e.currentTarget).text()
    paused(false)
  screenSize: $(window).width()
  updateHtml: (e) ->
    setTimeout ->
      $source = $(e.currentTarget)
      $slide = $source.closest ".slide"
      $target = $slide.find $source.data "target"
      if $target.length > 0
        $slide.find($target).html $source.text()
      else
        $source.next().html $source.text()
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

# attach an event listener to the window resize method to update the screen size
$(window).resize ->
  viewModel.set "screenSize", $(this).width()
  viewModel.set "containerWidth", $(".container-demo").width()

window.APP.slides.viewModel = viewModel