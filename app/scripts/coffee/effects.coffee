effect = kendo.fx
$current = null

done = ->
  $current = null
  $.publish "/effects/done"

# setup slides for effects
$.subscribe "/effects/setup", (e, el) ->
  el.find("[data-effect]").each ->
    $that = $ this
    effect = $that.data "effect"
    switch effect
      when "replace"
        $that.find("> *:not(:first-child)").hide()
      when "fragment"
        $that.children().hide()
      when "fadeIn"
        $that.hide()

# subscribe to events
$.subscribe "/effects/process", (e, el) ->
  $el = $(el)

  if $current is null
    $current = $el.children().first()

  switch $el.data "effect"
    when "replace"
        
      $next = $current.next()

      # we replace the first item with the second and so on
      kendo.fx($el).expand("vertical").duration(1000).reverse().then ->
        $current.hide()
        $next.show()
        
        # if this is the last item in the list, set $current to null and bail
        $current = $next
        if $current.next().length == 0 then done()

        setTimeout ->
          kendo.fx($el).expand("vertical").duration(1000).play().then ->
        ,1

    when "fragment"
      
      kendo.fx($current).fade("in").play().then ->
        if $current.next().length == 0 then done()
        else
          $current = $current.next()

    when "fadeIn"

      kendo.fx($el).fade("in").play().then ->
        done()


