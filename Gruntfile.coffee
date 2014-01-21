'use strict';

module.exports = (grunt) ->

  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  grunt.initConfig
    yeoman:
      app: 'app'
      dist: 'dist'

    watch:
#      coffee:
#        files: ['<%= yeoman.app %>/scripts/{,**/}*.{coffee,litcoffee,coffee.md}']
#        tasks: ['coffee:dist']
      compass:
        files: ['<%= yeoman.app %>/styles/{,**/}*.{scss,sass}']
        tasks: ['compass:server']
      livereload:
        options:
          livereload: '<%= connect.options.livereload %>'
        files: [
          '<%= yeoman.app %>/*.html'
          '.tmp/styles/{,*/}*.css'
          '.tmp/scripts/app.js'
          '<%= yeoman.app %>/images/{,**/}*.{gif,jpeg,jpg,png,svg,webp}'
        ]
      browserify:
        files: ['app/templates/**/*.hbs', 'app/scripts/**/*.coffee']
        tasks: ['browserify:app']
        options:
          debounceDelay: 250


    connect:
      options:
        port: 9000
        livereload: 35729
      # change this to '0.0.0.0' to access the server from outside
        hostname: 'localhost'

      livereload:
        options:
          open: true
          base: [
            '.tmp'
            '<%= yeoman.app %>'
          ]

      dist:
        options:
          open: true
          base: '<%= yeoman.dist %>'
          livereload: false


    clean:
      dist:
        files: [
          dot: true
          src: [
            '.tmp'
            '<%= yeoman.dist %>/*'
            '!<%= yeoman.dist %>/.git*'
          ]
        ]
      server: '.tmp'


    coffee:
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/scripts'
          src: '{,**/}*.{coffee,litcoffee,coffee.md}'
          dest: '.tmp/scripts'
          ext: '.js'
        ]


    compass:
      options:
        sassDir: '<%= yeoman.app %>/styles'
        cssDir: '.tmp/styles'
        generatedImagesDir: '.tmp/images/generated'
        imagesDir: '<%= yeoman.app %>/images'
        javascriptsDir: '<%= yeoman.app %>/scripts'
        fontsDir: '<%= yeoman.app %>/styles/fonts'
        importPath: 'bower_components'
        httpImagesPath: '/images'
        httpGeneratedImagesPath: '/images/generated'
        httpFontsPath: '/styles/fonts'
        relativeAssets: false
        assetCacheBuster: false

      dist:
        options:
          generatedImagesDir: '<%= yeoman.dist %>/images/generated'

      server:
        options:
          debugInfo: true


    useminPrepare:
      options:
        dest: '<%= yeoman.dist %>'
      html: '<%= yeoman.app %>/index.html'


    usemin:
      options:
        assetsDirs: ['<%= yeoman.dist %>']
      html: ['<%= yeoman.dist %>/{,*/}*.html']
      css: ['<%= yeoman.dist %>/styles/{,*/}*.css']


    imagemin:
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/images'
          src: '{,*/}*.{gif,jpeg,jpg,png}'
          dest: '<%= yeoman.dist %>/images'
        ]


    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: '<%= yeoman.app %>'
          src: [
            '*.{ico,png,txt}'
            '.htaccess'
            'images/{,*/}*.{webp,gif}'
            'styles/fonts/{,*/}*.*'
          ]
          dest: '<%= yeoman.dist %>'
        ,
          expand: true
          dot: true
          cwd: 'bower_components/font-awesome/fonts'
          src: ['*.*']
          dest: '<%= yeoman.dist %>/styles/fonts/'
        ]
      fonts:
        expand: true
        dot: true
        cwd: 'bower_components/font-awesome/fonts'
        src: '{,*/}*.*'
        dest: '.tmp/styles/fonts'


    concurrent:
      server: [
        'compass'
#        'coffee:dist'
        'copy:fonts'
        'browserify:app'
      ]
      dist: [
        'coffee'
        'compass'
        'imagemin'
      ]

    browserify:
      app:
        files:
          '.tmp/scripts/app.js': [
            'app/scripts/**/*.coffee'
            'app/scripts/**/*.js'
            'app/templates/**/*.hbs'
          ]
        options:
          debug: true
          transform: ['coffeeify', 'hbsfy']
          extensions: ['.coffee', '.hbs']
          insertGlobals: true
          aliasMappings: [
            {
              cwd: 'app/scripts/controllers'
              src: ['**/*.coffee']
              dest: 'controllers'
            }
            {
              cwd: 'app/templates'
              src: ['**/*.hbs']
              dest: 'templates'
            }
          ]
          shim:
            jquery:
              path: 'bower_components/jquery/jquery.js'
              exports: '$'


    grunt.registerTask 'serve', (target) ->
      if target is 'dist'
        grunt.task.run ['build', 'connect:dist:keepalive']
      else
        grunt.task.run [
          'clean:server'
          'concurrent:server'
          'connect:livereload'
          'watch'
        ]


    grunt.registerTask 'build', [
      'clean:dist'
      'useminPrepare'
      'concurrent:dist'
      'concat'
      'cssmin'
      'uglify'
      'copy:dist'
      'usemin'
    ]