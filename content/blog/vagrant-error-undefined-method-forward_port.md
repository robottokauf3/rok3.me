---
title: "Vagrant Error: undefined method forward_port"
description: "How to fix \"undefined method 'forward_port'\" error when using \"config.vm.forward_port\" in Vagrant 1.1 for Windows."
date: "2013-03-18"
tags: ["vagrant", "errors"]
categories: ["programming"]
draft: false
type: "post"
---

Ran into an interesting issue while using VirtualBox 4.2.10 with Vagrant 1.1.0 on a Windows 7 machine.

All of the Vagrant documentation I found was telling me to use the following code in my VagrantFile to forward port 80 on the guest to port 8080 on the host machine.

```ruby
config.vm.forward_port 80, 8080
```

When trying to bring the box up the following error was being thrown:

```
Vagrantfile:11:in 'block in <top (required)>': 
undefined method 'forward_port' for 
#<VagrantPlugins::Kernel_V2::VMConfig:0x28b2040> (NoMethodError)
```

I found tons of forum and blog posts which were stating that this was a problem with VirtualBox 4.2.10 and the fix was to roll back to the 4.1 series.
If you are using Vagrant 1.1 try the following syntax before downgrading.  It turns out that there was an update to the configuration file made in that version of Vagrant

Here's the new, working code:

```ruby
config.vm.network :forwarded_port, guest: 80, host: 8080
```

Make sure to check out the rest of the official [Vagrant Documentation](http://docs.vagrantup.com/v2).  There's way too many tweaks and updates to list here.
