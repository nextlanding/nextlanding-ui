exports.config =
# See docs at http://brunch.readthedocs.org/en/latest/config.html.
  conventions:
    assets: /^app\/assets\//
    vendor: -> true #hack to force brunch-coffeescript to wrap anonymous functions
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
          #jquery must be loaded before angular otherwise jqLite will be used
          'bower_components/jquery/jquery.js'
          'app/scripts/ng-modules/main/main.coffee'
          'app/scripts/ng-modules/apartment/apartment.coffee'
          'app/scripts/ng-modules/search/search.coffee'
          'app/scripts/ng-modules/google-maps/google-maps.coffee'
          'app/scripts/ng-modules/stripe/stripe.coffee'
          'app/scripts/ng-modules/lodash/lodash.coffee'
          'app/scripts/ng-modules/analytics/analytics.coffee'
          'app/scripts/ng-modules/momentjs/momentjs.coffee'
          'app/scripts/ng-modules/admin/admin.coffee'
          'app/scripts/ng-modules/result/result.coffee'
        ]
    stylesheets:
      joinTo:
        'css/app.css': /^(app|vendor)/
      order:
        before: [
          #our assets should be loaded before vendor assets so we can override sass variables
          'app/styles/app.scss'
        ]

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
