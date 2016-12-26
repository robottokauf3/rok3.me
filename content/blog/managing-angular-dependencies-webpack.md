---
title: "Managing Angular Dependencies with Webpack"
description: ""
date: "2014-11-08"
tags: ["angularjs", "webpack"]
categories: ["programming"]
draft: false
type: "post"
---

AngularJS is a powerful library that allows you to create some amazing applications with relative ease.  Unfortunately as the project grows, organization and structure start to become an issue.  I've played around with a few bundlers and decided that Webpack fit my needs on my large AngularJS projects.  Below I'll show you how you can manage your JS code using Webpack while automatically including new files and having the ability to output both expanded and minified code for your development and production environments.

Take the structure of a typical AngularJS application.

### Structure
```shell
Project_Folder
├── js
│   ├── controllers
|   │   ├── BaseController.jsa
│   │   └── IndexController.js
|   │
│   ├── directives
|   │   ├── ScrollTo.js
│   │   └── SlideOut.js
|   │
│   ├── filters
|   │   ├── Ellipsis.js
│   │   └── Ordinal.js
|   │
│   ├── services
|   │   ├── Session.js
│   │   └── Validate.js
|   │
│   ├── templates
│   └── vendor
|
├── partials
│   ├── one.html
│   └── two.html
|
├── css
├── img
|
└── index.html
```

Nothing out of the ordinary.  Directives, controllers, services, and filters are located in the appropriate folder to help keep everything nice and organized.  Now it's time to include all of your JS in your HTML page.

```html
<script src="/js/vendor/jquery.min.js"></script>
<script src="/js/vendor/angular.min.js"></script>
<script src="/js/vendor/angular-animate.min.js"></script>
<script src="/js/vendor/angular-cookies.min.js"></script>
<script src="/js/vendor/angular-resources.min.js"></script>
<script src="/js/vendor/angular-ui-router.min.js"></script>
<script src="/js/controllers/BaseController.js"></script>
<script src="/js/controllers/IndexController.js"></script>
<script src="/js/directives/ScrollTo.js"></script>
<script src="/js/directives/SlideOut.js"></script>
<script src="/js/services/Session.js"></script>
<script src="/js/services/Validate.js"></script>
```

Wow.  That's a lot of boilerplate to include all of your files and this application is relatively small.  Every time you add or remove a component you'll need to remember to update your HTML.  It's not the worst problem in the world but it adds yet another step to coding your application. Also, for performance reasons you want to keep the number of requests on the production code to a minimum. This is the point where a lot of developers will use a build system like Gulp, Grunt, or my favorite Make (I'm a bit of a sadist) to concatenate and minify all of your development files so that you only have to make 1 call for production.  Additionally, the build system would need to replace the above block of includes with the call to the new, minified file.  

I find this approach to be clunky and error prone.  Here's how you would do the same thing with Webpack.

### bundle.js

```javascript
// /js/entry.js
// Expose any global variables you need for your application
window.$ = window.jQuery = require('./vendor/jquery');

// Include all of your Angular modules
require('./vendor/angular-animate.min');
require('./vendor/angular-cookies.min');
require('./vendor/angular-resource.min');
require('./vendor/angular-ui-router.min');

// Main Application
require('./app');

// Services
require('./services/Session');
require('./services/Validate');

// Directives
require('./directives/ScrollTo');
require('./directives/SlideOut');

// Controllers
require('./controllers/BaseController');
require('./controllers/IndexController');
```

Now you can start Webpack up and it will generate a bundle.js file everytime you save, add, or delete a JS file in your application. This is the only JS file you will need to include in your HTML. Additionally, Webpack can be configured to produce expanded code for development environments and minified code with the comments stripped for production use.

```html
<script src="/js/bundle.js"></script>
```

Now you'll still need to remember to update your entry.js file every time you add or remove a file.  Luckily, there's a simple trick to get make this even easier.

```javascript
// jQuery
window.$ = window.jQuery = require('./vendor/jquery');

// Angular Modules
require('./vendor/angular-animate.min');
require('./vendor/angular-cookies.min');
require('./vendor/angular-resource.min');
require('./vendor/angular-ui-router.min');

// Main Application
require('./app');

// Services
var services = require.context('./services', true, /.js$/);
services.keys().forEach(services);

// Directives
var directives = require.context('./directives', true, /.js$/);
directives.keys().forEach(directives);

// Filters
var filters = require.context('./filters', true, /.js$/);
filters.keys().forEach(filters);

// Controllers
var controllers = require.context('./controllers', true, /.js$/);
controllers.keys().forEach(controllers);
```

If you want to create a new controller you just have to create the file and Webpack will take care of everything else.  
