---
title: "Compass – Set Cache Folder Location"
description: ""
date: "2013-08-27"
tags: ["sass", "compass"]
categories: ["programming"]
draft: false
type: "post"
---

By default Compass will place the .sass-cache folder in the project root directory.  I prefer to keep all caches and temporary file builds for my projects in the .tmp folder.

Luckily, Compass has the ability to set the cache folder location but it appears to be undocumented.

Simply ass the following to the config.rb for the project:

```ruby
cache_path = 'PREFERRED_PATH/.sass-cache'

# Eg.

cache_path = '.tmp/.sass-cache'
```

Note: The cache_path is relative to the config.rb file and not the project_path.

Tested with Compass v0.12.2
