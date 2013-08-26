window.loader = (function() {

      var Promise = function() {
        this.callbacks = [];
        this.isResolved = false;
      };
      
      Promise.prototype = {
        then: function(callback) {
          if (this.isResolved) {
            callback(this.data);
          } else {
            this.callbacks.push(callback);
          }
        },
        run: function(data) {
          this.data = data;
          this.isResolved = true;

          var length=this.callbacks.length;
          var i;
          for (i=0; i<length; i++){
            var cb = this.callbacks[i];
            cb(data);
          }
        }
      };

      var Defer = function() {
        this.promise = new Promise();
      };

      Defer.prototype = {
        resolve: function(data) {
          this.promise.run(data);
        }
      };

      var each = function(array, callback) {
        var defer = new Defer();
        var i, len = array.length;
        for (i = 0; i < len; i++) {
          if (i === len - 1) {
            defer.resolve();
          }
          callback(array[i]);
        }
        return defer.promise;
      };

      // var loadScripts = function(src, next) {
      //   var defer = new Defer();
      //   each(scripts, function(script, last) {
      //     var script = document.createElement("script");
      //     script.src = src;
      //     document.appendChild(script);
      //     if (last) {
      //       defer.resolve();
      //     }
      //   });
      //   return defer.promise;
      // }

      var loadStyles = function(styles) {
        var defer = new Defer();
        each(styles, function(href) {
          var style = document.createElement("link");
          style.rel = "stylesheet";
          style.href = href;
          document.head.appendChild(style);
        }).then(function() {
          defer.resolve();
        });
        return defer.promise;
      };

      var loadHtml = function(pages) {
        var defer = new Defer();
        var html = "";
        each(pages, function(url) {
          // make an xhr call for the page
          console.log(url);
          xhr(url).then(function(data) {
            html += data;
            console.log(html);
          });
        }).then(function() {
          var wrapper = document.createElement("div");
          wrapper.innerHTML = html;
          debugger;
          console.log(wrapper); 
        }); 
          
            
        //     each(wrapper.childNodes, function(node) {
        //       console.log(node);
        //       document.appendChild(node);
        //     }).then(function() {
        //       defer.resolve("I'm done loading HTML");
        //     });
        //   }
        // });
        return defer.promise;
      };

      var xhr = function(url) {
        var defer = new Defer();
        var req = new XMLHttpRequest();
        req.onreadystatechange = function() {
          if (req.readyState !== 4) {
            return;
          }
          else {
            defer.resolve(req.responseText);
          }
        };
        req.open("GET", url, true);
        req.send();
        return defer.promise;
      };

      return {
        load: function(file) {
          xhr(file).then(function(data) {
            data = JSON.parse(data);
            loadStyles(data.styles).then(function(){
              loadHtml(data.html).then(function(data) {
                console.log(data);
              });
            });
          });
        },
        loadStyles: loadStyles
      };

    })();

    