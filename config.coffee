exports.config =
# See docs at http://brunch.readthedocs.org/en/latest/config.html.
  conventions:
    assets: /^app\/assets\//
    vendor: (path) -> true #hack to force brunch-coffeescript to wrap anonymous functions
  modules:
    definition: false
    wrapper: false
  paths:
    public: '_public'
  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': (path) ->
          (path.indexOf("vendor") isnt -1 or path.indexOf("bower_components") isnt -1) \
          and path.indexOf("modernizr") is -1
        'js/modernizr.js': (path) ->
          path.indexOf('modernizr') isnt -1
      order:
        before:[
          'app/scripts/ng-modules/main/main.coffee'
          'app/scripts/ng-modules/apartment/apartment.coffee'
          'app/scripts/ng-modules/todo/todo.coffee'
          'app/scripts/ng-modules/search/search.coffee'
          'app/scripts/ng-modules/google-maps/google-maps.coffee'
        ]
    stylesheets:
      joinTo:
        'css/app.css': /^app/
        'css/vendor.css': /^(bower_components|vendor)/

    templates:
      joinTo:
        'js/dontUseMe': /^app/ # dirty hack for Jade compiling.

  plugins:
    jade:
      pretty: yes # Adds pretty-indentation whitespaces to output (false by default)
    jade_angular:
      modules_folder: 'partials'
      locals: {}

# Enable or disable minifying of result js / css files.
# minify: true
