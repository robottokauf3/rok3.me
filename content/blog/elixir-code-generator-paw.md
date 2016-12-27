---
title: "Elixir Code Generator for Paw"
description: "Paw extension for Elixir code generation with the HTTPoison library."
date: "2016-12-26"
tags: ["elixir", "tools"]
categories: ["programming"]
featured: "elixir_paw_screenshot.png"
featuredPath: "date"
draft: false
type: "post"
---

I really love the [Paw](http://paw.cloud) HTTP client.  One of my favorite features is the ability to export requests in a variety of languages to share with other developers or drop into a quick project.

Lately I've been spending a lot of time writing Elixir and mentoring other developers on the language and various frameworks. Elixir is a relatively new language so there wasn't a code generator extension available for it. After taking a quick look at some of the other extensions and Paw's excellent documentation I'm ready to release V1.0.0 of the Elixir code generator extension.

[Source and Packages](https://github.com/robottokauf3/Paw-ElixirHTTPosionCodeGenerator)

If you run into any issues please open a ticket or submit a PR on the [Github](https://github.com/robottokauf3/Paw-ElixirHTTPosionCodeGenerator/issues) page.

------------------

## Installation 

I've reached out to Paw about having Elixir added to their list of extensions and being able to use the in-app installation process.  Until then you can install the extension as follows:

```shell
$ git clone https://github.com/robottokauf3/Paw-ElixirHTTPosionCodeGenerator
$ cd Paw-ElixirHTTPosionCodeGenerator
$ make install
```

You should now have `Elixir(HTTPoison)` listed in the code generators drop down menu.
