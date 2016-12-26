---
title: "Logentries Library for the Go Programming Language"
description: ""
date: "2014-06-13"
tags: ["go", "logentries"]
categories: ["programming"]
draft: false
type: "post"
---

After trying out a bunch of online logging services I've really come to enjoy and rely on [Logentries](http://www.logentries.com) so I whipped up a library for Golang to support the service. It uses the token-based input and has the option to use SSL.

Take a look below.

[Github](https://github.com/robottokauf3/go-logentries)

## Installation 

```shell
go get github.com/robottokauf3/go-logentries
```

## Basic Usage

```go
package main
import (
    "fmt"
    "logentries"
)
func main() {
    // Using standard TCP connection
    logger, _ := logentries.New("1a2b3c4d-5e6f-7g8h-9i0j-1k2l3m4n", false)
    logger.Debug("Important Debugging Message")

    // Using SSL connection
    sslLogger, _ := logentries.New("1a2b3c4d-5e6f-7g8h-9i0j-1k2l3m4n", true)
    sslLogger.Debug("Secret Debugging Message")
}
```
