// Karma configuration
// Generated on Tue Jan 19 2016 13:29:07 GMT+0100 (CET)

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '../../../',


    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine'],

    preprocessors: {
     '**/*.coffee': ['coffee'],
     '**/*.haml': ['ng-haml2js']
    },
    ngHaml2JsPreprocessor: {
      // strip this from the file path
      stripPrefix: 'public/',
     // prepend this to the
     prependPrefix: 'served/',
     // or define a custom transform function


  // setting this option will create only a single module that contains templates
  // from all the files, so you can load them all with module('foo')
  moduleName: 'templates'
},
    // list of files / patterns to load in the browser
    files: [
    'vendor/assets/bower_components/angular/angular.js',
    'vendor/assets/bower_components/angular-route/angular-route.js',
    'vendor/assets/bower_components/angular-mocks/angular-mocks.js',
    'vendor/assets/bower_components/AngularDevise/test/devise.js',
    'spec/javascripts/*.coffee',
    'app/assets/javascripts/*.{js,coffee}',
    'app/assets/javascripts/filter/*.{js,coffee}',
    '**/*.haml'
    ],


    // list of files to exclude
    exclude: [
    ],

    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress'],


    // web server port
    port: 9876,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['PhantomJS'],


    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: true,

    // Concurrency level
    // how many browser should be started simultaneous
    concurrency: Infinity
  })
}
