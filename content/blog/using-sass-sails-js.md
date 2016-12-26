---
title: "Using Sass with Sails.js"
description: ""
date: "2013-11-26"
tags: ["nodejs", "sailsjs", "sass"]
categories: ["programming"]
draft: false
type: "post"
---

If you're not using Sass in your projects you should drop everything, read about it at [http://sass-lang.com/](http://sass-lang.com/) and start using it in your projects immediately.  I've been using [Sails.js](http://sailsjs.org/) a lot lately and enjoying it immensely. Unfortunately while it supports Sass' cousin, Less, you have to make some configuration changes to get Sass to work.

Luckily you can do it in 4 easy steps.

### 1) Install [Grunt Sass plugin](https://github.com/gruntjs/grunt-contrib-sass).

```shell
npm install grunt-contrib-sass --save
```

### 2) Load the Sass plugin in Gruntfile.js
```js
// Get path to core grunt dependencies from Sails
var depsPath = grunt.option('gdsrc') || 'node_modules/sails/node_modules';
grunt.loadTasks(depsPath + '/grunt-contrib-clean/tasks');
grunt.loadTasks(depsPath + '/grunt-contrib-copy/tasks');
grunt.loadTasks(depsPath + '/grunt-contrib-concat/tasks');
grunt.loadTasks(depsPath + '/grunt-sails-linker/tasks');
grunt.loadTasks(depsPath + '/grunt-contrib-jst/tasks');
grunt.loadTasks(depsPath + '/grunt-contrib-watch/tasks');
grunt.loadTasks(depsPath + '/grunt-contrib-uglify/tasks');
grunt.loadTasks(depsPath + '/grunt-contrib-cssmin/tasks');
grunt.loadTasks(depsPath + '/grunt-contrib-less/tasks');
grunt.loadTasks(depsPath + '/grunt-contrib-coffee/tasks');
grunt.loadTasks('node_modules/grunt-contrib-sass/tasks'); // Add this
  //Change the above line to match installation directory if not local          
```

### 3) Add Sass:Dev task
```js
sass: {
  dev: {
    options: {
      style: 'expanded' //Set your prefered style for development here.
    },
    files: [{
      expand: true,
      cwd: 'assets/styles/',
      src: ['*.scss', '*.sass'], // Feel free to remove a format if you do not use it.
      dest: '.tmp/public/styles/',
      ext: '.css'
    }, {
      expand: true,
      cwd: 'assets/linker/styles/',
      src: ['*.scss', '*.sass'], // Feel free to remove a format if you do not use it.
      dest: '.tmp/public/linker/styles/',
      ext: '.css'
    }
    ]
  }
},
```

### 4) Update the 'compileAssets' task.

```js
  grunt.registerTask('compileAssets', [
    'clean:dev',
    'jst:dev',
    'less:dev',
    'sass:dev', //Add this line
    'copy:dev',    
    'coffee:dev'
  ]);
```

### and the 'prod' task.
```js
  grunt.registerTask('prod', [
    'clean:dev',
    'jst:dev',
    'less:dev',
    'sass:dev', //Add this line
    'copy:dev',
    'coffee:dev',
    'concat',
    'uglify',
    'cssmin',
    'sails-linker:prodJs',
    'sails-linker:prodStyles',
    'sails-linker:devTpl',
    'sails-linker:prodJsJADE',
    'sails-linker:prodStylesJADE',
    'sails-linker:devTplJADE'
  ]);
```

While running `sails lift` any changes made to your scss / sass files will be compiled and included in your application.

*This tutorial was written using Sails 0.9.7.  Individual mileage may vary.*
