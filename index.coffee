###
Modo de uso
===========

```javascript
var gulp  = require('gulp');
var stack = require('gulpstack');

stack(gulp);
```

Tareas incluidas
----------------


```sh
$ gulp [watch|markdown|stylus|sass|coffee|jade]
```

- watch: Permite compilar el contenido muentras este se este editando.
- markdown: Compila el contenido de tipo Markdown.
- stylus: Compila el contenido de tipo Stylus.
- sass: Compila el contenido de tipo Sass.
- coffee: Compila el contenido de tipo Coffee.
- jade: Compila el contenido de tipo Jade.

Ejemplo
-------

```sh
gulp watch
```
###

# Export source
expr = (gulp,config = {}) ->

  # if not require then require = ->

  #
  # Dependencias
  #
  coffee     = require 'gulp-coffee'
  concat     = require 'gulp-concat'
  concatCss  = require 'gulp-concat-css'
  connect    = require 'gulp-connect'
  cssmin     = require 'gulp-cssmin'
  fs         = require 'fs'
  gutil      = require 'gulp-util'
  include    = require 'gulp-include'
  jade       = require 'gulp-jade'
  markdown   = require 'gulp-markdown'
  minify     = require 'gulp-minify'
  minifyCSS  = require 'gulp-minify-css'
  rename     = require 'gulp-rename'
  sass       = require 'gulp-sass'
  sourcemaps = require 'gulp-sourcemaps'
  stylus     = require 'gulp-stylus'
  watch      = require 'gulp-watch'


  #
  # Configuraciones
  #
  folder_dest           = config.dest || process.env.FOLDER_DEST || 'dest'
  folder_src            = config.src || process.env.FOLDER_SRC || 'src'
  script_to_concat      = config.scripts || []
  styles_to_concat      = config.styles  || []
  name_script_to_concat = config.nameContactScript || "script.js"
  name_styles_to_concat = config.nameContactStyle || "style.css"

  # Rutas y destinos
  __base = config.patch || do process.cwd

  dest = "#{__base}/#{folder_dest}"
  src  = "#{__base}/#{folder_src}"

  names =
    coffee   : config.coffee || 'coffee'
    css      : config.css || 'css'
    html     : config.html || 'html'
    jade     : config.jade || 'jade'
    markdown : config.markdown || 'markdown'
    sass     : config.sass || 'sass'
    stylus   : config.stylus || 'stylus'

  names_dest =
    css      : 'css'
    html     : ''
    js       : 'js'
    markdown : 'html'

  matchs =
    coffee   : "#{src}/#{names.coffee}/**/[a-zA-Z0-9]*.coffee"
    jade     : "#{src}/#{names.jade}/**/[a-zA-Z0-9]*.jade"
    markdown : "#{src}/#{names.markdown}/**/*.{markdown,md,mdown}"
    sass     : "#{src}/#{names.sass}/**/[a-zA-Z0-9]*.{scss,sass}"
    stylus   : "#{src}/#{names.stylus}/**/[a-zA-Z0-9]*.styl"
    watch    :
      coffee   : "#{src}/#{names.coffee}/**/*.coffee"
      jade     : "#{src}/#{names.jade}/**/*.jade"
      markdown : "#{src}/#{names.markdown}/**/*.{markdown,md,mdown}"
      sass     : "#{src}/#{names.sass}/**/*.{scss,sass}"
      stylus   : "#{src}/#{names.stylus}/**/*.styl"

  # Rutas de destino
  dests =
    css      : "#{dest}/#{names_dest.css}"
    html     : "#{dest}/#{names_dest.html}"
    js       : "#{dest}/#{names_dest.js}"
    markdown : "#{dest}/#{names_dest.markdown}"

  #
  # Tareas
  #
  gulp.task 'markdown', ->
    gulp.src matchs.markdown
      .pipe do markdown
      .pipe gulp.dest dests.markdown
      .pipe do connect.reload

  gulp.task 'stylus', ->
    gulp.src matchs.stylus
      .pipe do stylus
      .pipe gulp.dest dests.css
      .pipe do cssmin
      .pipe rename suffix: '.min'
      .pipe gulp.dest dests.css
      .pipe do connect.reload

  gulp.task 'sass', ->
    gulp.src matchs.sass
      .pipe do sass
      .pipe gulp.dest dests.css
      .pipe do cssmin
      .pipe rename suffix: '.min'
      .pipe gulp.dest dests.css
      .pipe do connect.reload

  gulp.task 'coffee', ->
    gulp.src matchs.coffee
      .pipe do include
      .pipe do sourcemaps.init
      .pipe do coffee
      .pipe do minify
      # .on 'error', gutil.log
      .pipe sourcemaps.write '.'
      .pipe gulp.dest dests.js
      .pipe do connect.reload

  gulp.task 'jade', ->
    gulp.src matchs.jade
      .pipe do jade
      .pipe gulp.dest dests.html
      .pipe do connect.reload

  gulp.task 'concat', [
    'coffee'
    ], ->
    gulp.src script_to_concat
      .pipe concat name_script_to_concat
      .pipe do minify
      .pipe gulp.dest dests.js
      .pipe do connect.reload

  gulp.task 'concat-css', [
    'sass'
    'stylus'
    ], ->
    gulp.src styles_to_concat
      .pipe concatCss name_styles_to_concat
      .pipe do minify
      .pipe gulp.dest dests.css
      .pipe do connect.reload

  gulp.task 'init', ->

    try fs.mkdirSync "#{src}"
    try fs.mkdirSync "#{dest}"
    for index, name of names
      try fs.mkdirSync "#{src}/#{name}"

  gulp.task 'debug', [
    'coffee'
    'jade'
    'markdown'
    'sass'
    'stylus'
    'concat'
    'concat-css'
    ]

  gulp.task 'connect', ->
    connect.server
      root: ["#{dest}", 'bower_components']
      livereload: true



  #
  # Watch
  #
  gulp.task 'watch', [
    # 'debug'
    'connect'
    ] , ->
    gulp.watch matchs.watch.coffee,   ['coffee'] # old: concat
    gulp.watch matchs.watch.jade,     ['jade']
    gulp.watch matchs.watch.markdown, ['markdown', 'jade']
    gulp.watch matchs.watch.sass,     ['sass'] # concat-css
    gulp.watch matchs.watch.stylus,   ['stylus'] # concat-css
    return



# End Source
module.exports = exports = expr
