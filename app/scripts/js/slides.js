// Generated by CoffeeScript 1.6.3
(function() {
  var app, effectsQueue, idCounter, next, nextSlide, paused, previous, slideNumber;

  slideNumber = 1;

  nextSlide = 2;

  effectsQueue = [];

  paused = false;

  $(".slide").kendoTouch({
    surface: $(".slide"),
    enableSwipe: true,
    swipe: function(e) {}
  });

  previous = function() {
    nextSlide = slideNumber - 1;
    if (nextSlide > 0) {
      app.navigate("#slide" + nextSlide);
      return slideNumber = nextSlide;
    }
  };

  next = function() {
    nextSlide = slideNumber + 1;
    if (nextSlide <= idCounter) {
      if (effectsQueue.length > 0) {
        return $.publish("/effects/process", [effectsQueue[0]]);
      } else {
        app.navigate("#slide" + nextSlide);
        return slideNumber = nextSlide;
      }
    }
  };

  $(document).keydown(function(e) {
    if (e.keyCode === 9) {
      paused = false;
    }
    if (!paused) {
      if (e.keyCode === 37) {
        previous();
        return false;
      }
      if (e.keyCode === 39) {
        next();
        return false;
      }
    }
  });

  $.subscribe("/effects/done", function() {
    return effectsQueue.splice(0, 1);
  });

  $.subscribe("/controls/paused", function(e, flag) {
    return paused = flag;
  });

  window.APP.slides.init = function(e) {
    return slideNumber = parseInt(this.element.data("slide"));
  };

  window.APP.slides.show = function(e) {
    var $slide, fit;
    $slide = e.view.element;
    fit = $slide.find(".fit");
    fit.fitText(fit.data("fit") || 1);
    effectsQueue = $slide.find("[data-effect]");
    return $.publish("/effects/setup", [$slide]);
  };

  idCounter = 1;

  $("[data-role='view']").each(function() {
    var $that;
    $that = $(this);
    $that.attr("id", "slide" + idCounter);
    $that.attr("data-slide", idCounter);
    $that.attr("data-init", "APP.slides.init");
    $that.attr("data-show", "APP.slides.show");
    $that.attr("data-layout", "slideDeck");
    $that.attr("data-stretch", "true");
    return idCounter++;
  });

  app = new kendo.mobile.Application(document.body, {
    initial: "slide1",
    transition: "fade"
  });

}).call(this);
