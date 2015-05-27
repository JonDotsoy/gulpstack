gulpstack
=========

Una colección con tareas predefinidas para [gulp](http://gulpjs.com/).

 - [coffee](http://coffeescript.org/)
 - [jade](http://jade-lang.com/)
 - [markdown](http://en.wikipedia.org/wiki/Markdown)
 - [sass](http://sass-lang.com/)
 - [stylus](https://learnboost.github.io/stylus/)

También permite concatenar los scripts y los styles.


Como Instalar
-------------

Para instalar ejecutamos el siguiente comando la raíz del proyecto.

```bash
$ npm install --save-dev gulpstack
```

Como Utilizar
-------------

Para esto debes de tener ya listo el documento [gulpfile.js](https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md#3-create-a-gulpfilejs-at-the-root-of-your-project) e incluir el siguiente paquete.

```javascript
var gulp  = require('gulp');
var stack = require('gulpstack');

stack(gulp);
```

Preparar proyecto
-----------------

Para prepara el proyecto nos gusta preparar el directorio del proyecto usando el comando `init`.

```javascript
$ gulp init
```

Compilar el proyecto
--------------------

Una ves teniendo el directorio con la estructura de carpetas echas se debe de compilar los archivos con los pre-procesadores con el comando `debug`.

```javascript
$ gulp debug
```


Montar el servidor
------------------

En cuanto estemos construyendo el proyecto nos gustara ver el resultado del código mientras estemos modifican el código. Para esto usamos el comando `watch`.

```javascript
$ gulp watch
```
