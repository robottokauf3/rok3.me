---
title: "Configuring Postgresql with Sails.js"
description: ""
date: "2013-11-22"
tags: ["nodejs", "postresql", "sailsjs"]
categories: ["programming"]
draft: false
type: "post"
---

I've been playing with [Sails.js](http://sailsjs.com) a lot lately and was thrilled that it supported my favorite database, Postgresql. Unfortunately the documentation on configuring the adapter left a lot to be desired.

## Installing Postgresql Adapter

Installation is extremely easy thanks to NPM.  Just enter the following command from the root directory of your project.

```shell
npm install sails-postgresql --save
```

## Configuring the Adapter

1) Comment out or remove the code from the config/adapters.js files.

2) Update your local.js file to look like the following:

```js
//config/local.js

module.exports = {

  port: process.env.PORT || 1337,
  
  environment: process.env.NODE_ENV || 'development',

  adapters: {

    'default': 'postgres',

    postgres: {
      module   : 'sails-postgresql',
      host     : 'localhost',
      port     : 27017,
      user     : 'USERNAME',
      password : 'SUPER_SECURE_PASSWORD',
      database : 'DATABASE_NAME',

      schema: true //This makes sure that sails matches 
                   //the database schema to your models.
    }

  }

};
```

Techincally, you can place the configuration in the adapters.js file but I do not like this approach.

The local.js file is included in the .gitignore file by default so there's less chance of accidentally publishing your username and password.  Also, if you are working in a team or deploying to multiple machines you don't need to worry about loading the wrong settings from the adapters.js file.
