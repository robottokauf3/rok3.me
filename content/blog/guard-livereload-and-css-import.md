---
title: "Guard LiveReload and CSS @import"
description: "Guard LiveReload is an amazing tool to speed up your web development but doesn't reload CSS files linked using @import. Luckily there is an easy fix!"
date: "2013-01-27"
tags: ["guard", "css"]
categories: ["programming"]
draft: false
type: "post"
---

Let me preface this post with the following statement: **Don't use @import for CSS files!** It blocks parallel downloading so your browser has to wait for the CSS files to load before moving on.

Unfortunately, sometimes you are stuck using @import and if you are also using [Guard::LiveReload](https://github.com/guard/guard-livereload) you will notice that your browser is not using the updated stylesheets when you save them.

To fix that simply set the `apply_css_live` option as false in your GuardFile

```ruby
guard 'livereload', :apply_css_live => false do
  watch(%r{/*.php })
  watch(%r{sites/all/themes/rok3/css/*})
  watch(%r{sites/all/themes/rok3/images/*})
end
```

Guard::LiveReload will now do a full refresh of the browser instead of applying the CSS live.  It's a little clunkier than when you are using CSS from link tags but at least you don't have to hit F5.
