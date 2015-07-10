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
expr = (gulp, config = {}) ->

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
  mkdirp     = require 'mkdirp'
  path       = require 'path'
  rename     = require 'gulp-rename'
  sass       = require 'gulp-sass'
  sourcemaps = require 'gulp-sourcemaps'
  stylus     = require 'gulp-stylus'
  watch      = require 'gulp-watch'



  #
  # Configuraciones
  #
  disable_tasks         = config.tasks             || {}
  externals             = config.externals         || {}
  folder_dest           = config.dest              || process.env.FOLDER_DEST || 'dest'
  folder_src            = config.src               || process.env.FOLDER_SRC  || 'src'
  name_script_to_concat = config.nameContactScript || "script.js"
  name_styles_to_concat = config.nameContactStyle  || "style.css"
  script_to_concat      = config.scripts           || []
  styles_to_concat      = config.styles            || []

  #
  # Rutas de destino y origen.
  #
  __base = config.patch || do process.cwd

  dest = path.join "#{__base}", "#{folder_dest}"
  src  = path.join "#{__base}", "#{folder_src}"

  #
  # Nombre con los directorios que contengan el origen de los distintos tipos de
  # archivos.
  #
  names =
    coffee   : config.coffee   || 'coffee'
    css      : config.css      || 'css'
    font     : config.font     || 'font'
    fonts    : config.fonts    || 'fonts'
    html     : config.html     || 'html'
    images   : config.images   || 'images'
    jade     : config.jade     || 'jade'
    js       : config.js       || 'js'
    markdown : config.markdown || 'markdown'
    sass     : config.sass     || 'sass'
    styles   : config.styles   || 'styles'
    stylus   : config.stylus   || 'stylus'

  #
  # Nombre de los directorios de destino.
  #
  names_dest =
    coffee   : 'coffee'
    css      : 'css'
    font     : 'font'
    html     : ''
    images   : 'images'
    js       : 'js'
    markdown : 'html'


  #
  # Ruta de los directorios de origen.
  #
  centralDirectory =
    coffee   : path.join "#{src}", "#{names.coffee}"
    css      : path.join "#{src}", "#{names.css}"
    font     : path.join "#{src}", "#{names.font}"
    images   : path.join "#{src}", "#{names.images}"
    images   : path.join "#{src}", "#{names.images}"
    jade     : path.join "#{src}", "#{names.jade}"
    js       : path.join "#{src}", "#{names.js}"
    markdown : path.join "#{src}", "#{names.markdown}"
    sass     : path.join "#{src}", "#{names.sass}"
    stylus   : path.join "#{src}", "#{names.stylus}"



  #
  # Rutas de búsqueda (Match) para encontrar los archivos que se usaran para
  # compilar.
  #
  matchs =
    coffee    : [path.join centralDirectory.coffee, "**", "[a-zA-Z0-9]*.coffee"]
    coffeesrc : [path.join "#{dest}", "#{names_dest.coffee}", "**", "[a-zA-Z0-9]*.coffee"]
    css       : [path.join centralDirectory.css, "**", "[a-zA-Z0-9]*.css"]
    font      : [path.join centralDirectory.font, "**", "[a-zA-Z0-9]*.{ttf,woff,woff2,svg,eot}"]
    images    : [path.join centralDirectory.images, "**", "[a-zA-Z0-9]*.{jpg,jpeg,png,gif,svg}"]
    jade      : [path.join centralDirectory.jade, "**", "[a-zA-Z0-9]*.jade"]
    js        : [path.join centralDirectory.js, "**", "[a-zA-Z0-9]*.js"]
    markdown  : [path.join centralDirectory.markdown, "**", "*.{markdown,md,mdown}"]
    sass      : [path.join centralDirectory.sass, "**", "[a-zA-Z0-9]*.{scss,sass}"]
    stylus    : [path.join centralDirectory.stylus, "**", "[a-zA-Z0-9]*.styl"]

    # Actúan como visor
    watch :
      coffee   : path.join "#{src}", "#{names.coffee}", "**", "*.coffee"
      css      : path.join "#{src}", "#{names.css}", "**", "*.css"
      images   : path.join "#{src}", "#{names.images}", "**", "*.{jpg,jpeg,png,gif,svg}"
      jade     : path.join "#{src}", "#{names.jade}", "**", "*.jade"
      js       : path.join "#{src}", "#{names.js}", "**", "*.js"
      markdown : path.join "#{src}", "#{names.markdown}", "**", "*.{markdown,md,mdown}"
      sass     : path.join "#{src}", "#{names.sass}", "**", "*.{scss,sass}"
      stylus   : path.join "#{src}", "#{names.stylus}", "**", "*.styl"


  if externals.css
    for indexNamecss, namecss of externals.css
      matchs.css.push namecss

  if externals.font
    for indexNamefont, namefont of externals.font
      matchs.font.push namefont

  if externals.js
    for indexNamejs, namejs of externals.js
      matchs.js.push namejs

  if externals.coffee
    for indexNamecoffee, namecoffee of externals.coffee
      matchs.coffee.push namecoffee

  if externals.images
    for indexNameimages, nameimages of externals.images
      matchs.images.push nameimages

  if externals.sass
    for indexNamesass, namesass of externals.sass
      matchs.sass.push namesass

  if externals.stylus
    for indexNamestylus, namestylus of externals.stylus
      matchs.stylus.push namestylus



  #
  # Rutas de destino
  #
  dests =
    coffee   : path.join "#{dest}", "#{names_dest.coffee}"
    css      : path.join "#{dest}", "#{names_dest.css}"
    font     : path.join "#{dest}", "#{names_dest.font}"
    html     : path.join "#{dest}", "#{names_dest.html}"
    images   : path.join "#{dest}", "#{names_dest.images}"
    js       : path.join "#{dest}", "#{names_dest.js}"
    markdown : path.join "#{dest}", "#{names_dest.markdown}"

  #
  # Tareas Programadas
  #
  gulp.task 'markdown', ->
    if not (disable_tasks["markdown"] is false)
      gulp.src matchs.markdown
        .pipe do markdown
        .on 'error', (err) ->
          console.log err.stack
          @emit 'end'
        .pipe gulp.dest dests.markdown
        .pipe do connect.reload


  gulp.task 'stylus', ->
    if not (disable_tasks["stylus"] is false)
      gulp.src matchs.stylus
        .pipe do stylus
        .on 'error', (err) ->
          console.log err.stack
          @emit 'end'
        .pipe gulp.dest dests.css
        .pipe do cssmin
        .on 'error', (err) ->
          console.log err.stack
          @emit 'end'
        .pipe rename suffix: '.min'
        .pipe gulp.dest dests.css
        .pipe do connect.reload


  gulp.task 'sass', ->
    if not (disable_tasks["sass"] is false)
      gulp.src matchs.sass
        .pipe do sass
        .on 'error', (err) ->
          console.log err.stack
          @emit 'end'
        .pipe gulp.dest dests.css
        .pipe do cssmin
        .on 'error', (err) ->
          console.log err.stack
          @emit 'end'
        .pipe rename suffix: '.min'
        .pipe gulp.dest dests.css
        .pipe do connect.reload


  gulp.task 'coffee-include', ->
    if not (disable_tasks['coffee-include'] is false)
      gulp.src matchs.coffee
        .pipe do include
        .on 'error', (err) ->
          console.log err.stack
          @emit 'end'
        .pipe gulp.dest dests.coffee


  gulp.task 'coffee', [
    'coffee-include'
    ], ->
    if not (disable_tasks["coffee"] is false)
      gulp.src matchs.coffeesrc
        .pipe do sourcemaps.init
        .pipe do coffee
        .on 'error', (err) ->
          console.log err.stack
          @emit 'end'
        .pipe do minify
        .on 'error', (err) ->
          console.log err.stack
          @emit 'end'
        .pipe sourcemaps.write '.',
          sourceRoot: '/coffee'
        .pipe gulp.dest dests.js
        .pipe do connect.reload


  gulp.task 'jade', ->
    if not (disable_tasks["jade"] is false)
      gulp.src matchs.jade
        .pipe do jade
        .on 'error', (err) ->
          console.log err.stack
          @emit 'end'
        .pipe gulp.dest dests.html
        .pipe do connect.reload

  gulp.task 'concat', [
    'coffee'
    ], ->
    if not (disable_tasks["concat"] is false)
      gulp.src script_to_concat
        .pipe concat name_script_to_concat
        .pipe do minify
        .on 'error', (err) ->
          console.log err.stack
          @emit 'end'
        .pipe gulp.dest dests.js
        .pipe do connect.reload

  gulp.task 'concat-css', [
    'sass'
    'stylus'
    ], ->
    if not (disable_tasks["concat-css"] is false)
      gulp.src styles_to_concat
        .pipe concatCss name_styles_to_concat
        .pipe do minify
        .on 'error', (err) ->
          console.log err.stack
          @emit 'end'
        .pipe gulp.dest dests.css
        .pipe do connect.reload

  ### Tasks Init ###
  gulp.task 'init', ->
    if not (disable_tasks["init"] is false)

      try
        if not fs.existsSync src
          console.log "Created the directory \"#{src}\"."
          mkdirp.sync src

      try
        if not fs.existsSync dest
          console.log "Created the directory \"#{dest}\"."
          mkdirp.sync dest

      for indexCentralDirectory, nameCentralDirectory of centralDirectory
        try
          if not fs.existsSync nameCentralDirectory
            console.log "Created the directory \"#{nameCentralDirectory}\"."
            mkdirp.sync nameCentralDirectory

      for indexDirectoryDests, nameDirectoryDests of dests
        try
          if not fs.existsSync nameDirectoryDests
            console.log "Created the directory \"#{nameDirectoryDests}\"."
            mkdirp.sync nameDirectoryDests

  gulp.task 'copy-css', ->
    if not (disable_tasks["copy-css"] is false)
      gulp.src matchs.css
        .pipe gulp.dest dests.css

  gulp.task 'copy-js', ->
    if not (disable_tasks["copy-js"] is false)
      gulp.src matchs.js
        .pipe gulp.dest dests.js


  gulp.task 'copy-images', ->
    if not (disable_tasks["copy-images"] is false)
      gulp.src matchs.images
        .pipe gulp.dest dests.images


  gulp.task 'copy-font', ->
    if not (disable_tasks["copy-font"] is false)
      gulp.src matchs.font
        .pipe gulp.dest dests.font


  ### End Tasks Init ###


  gulp.task 'debug', [
    'coffee'
    'jade'
    'markdown'
    'sass'
    'stylus'
    'concat'
    'concat-css'
    'copy-css'
    'copy-js'
    'copy-images'
    'copy-font'
    ]


  gulp.task 'connect', ->
    if not (disable_tasks["connect"] is false)
      connect.server
        root: [
          path.join "#{dest}"
          path.join "#{src}", "public"
          path.join "#{__base}" ,"bower_components"
        ]
        livereload: true



  #
  # Watch
  #
  gulp.task 'watch', [
    # 'debug'
    'connect'
    ] , ->
    if not (disable_tasks["watch"] is false)

      gulp.watch matchs.watch.coffee,   ['coffee'] # old: concat
      gulp.watch matchs.watch.jade,     ['jade']
      gulp.watch matchs.watch.markdown, ['markdown', 'jade']
      gulp.watch matchs.watch.sass,     ['sass'] # concat-css
      gulp.watch matchs.watch.stylus,   ['stylus'] # concat-css
      gulp.watch script_to_concat,      ['concat']
      gulp.watch styles_to_concat,      ['concat-css']

      gulp.watch matchs.watch.css,      ['copy-css'] # concat-css
      gulp.watch matchs.watch.js,       ['copy-js'] # concat-css
      gulp.watch matchs.watch.images,   ['copy-images'] # concat-css

      return



# End Source
module.exports = exports = expr
