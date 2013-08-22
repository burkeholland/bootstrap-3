router = new kendo.Router()

# subscribe to events
$.subscribe "/router/navigate", (e, path) ->
  router.navigate path

$.subscribe "/router/start", ->
  router.start()

router.route "/slides/:id", (id) ->
  $.publish "/slides/show", [parseInt(id, 0)]

router.route "/", ->
  router.navigate "/slides/1"