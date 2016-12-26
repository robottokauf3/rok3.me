---
title: "Recursively Include Routes in Node.js and Express"
description: "Sick of having either massive controller files or 50 million require statements in your Express applications? Here's a simple trick to load everything with 1 line."
date: "2014-03-20"
tags: ["nodejs", "express"]
categories: ["programming"]
draft: false
type: "post"
---

Organizing Node.js applications can be a chore.  They either have massive route / controller files which cover way too many concerns or they are broken into smaller files with 50 million require statements.

 Consider the following folder structure:

```shell
Project_Folder
├── config
│   ├── index.js
├── models
│   ├── Model1.js
│   ├── Model2.js
│   └── Model3.js
├── public
├── routes
│   ├── admin
│   │   └── index.js
│   ├── dash
│   └── index.js
├── views
│   ├── admin
│   │   ├── index.ect
│   │   └── accounts.ect
│   ├── dash
│   │   └── index.ect
│   └── layout.ect
├── package.json
├── README.md
└── server.js
```


This is great for separating individual components into easy to manage files that focus on a single task.  Unfortunately, on larger projects you might end up with something like the following block in your server.js file:

```javascript
require('./routes/admin/index.js');
require('./routes/admin/accounts.js');
require('./routes/admin/campaigns.js');
require('./routes/admin/idontevenknow.js');
require('./routes/dash/index.js');
require('./routes/dash/widgets.js');
require('./routes/dash/williteverend.js');
// ...
```

That's a lot of boilerplate to simply include all of your routes.  For the last few months I've been using the following <code>routes/index.js</code> file to save me from require spam: 

```javascript
// routes/index.js
var fs = require('fs'),
    validFileTypes = ['js'];

var requireFiles = function (directory, app) {
  fs.readdirSync(directory).forEach(function (fileName) {
    // Recurse if directory
    if(fs.lstatSync(directory + '/' + fileName).isDirectory()) {
      requireFiles(directory + '/' + fileName, app);
    } else {

      // Skip this file
      if(fileName === 'index.js' && directory === __dirname) return;

      // Skip unknown filetypes
      if(validFileTypes.indexOf(fileName.split('.').pop()) === -1) return;

      // Require the file.
      require(directory + '/' + fileName)(app);
    }
  })
}

module.exports = function (app) {
  requireFiles(__dirname, app);
}
```

The script recursively searches your 'routes' directory and loads all of your controller files.  To load all of your controllers you simply need to require the 'routes' directory:


```javascript
require('./routes')(app);
```

Your route / controller files would like something like this:

```javascript
// routes/admin/accounts.js
module.exports = function (app) {
  app.get('/admin/accounts', function (req, res) {
    // Controller logic
    res.render('admin/accounts.ect');
  });
}
```

Enjoy!
