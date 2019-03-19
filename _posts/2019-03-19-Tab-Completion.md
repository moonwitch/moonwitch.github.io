---
layout: post
title: AutoComplete
comments: true
category: blog
---
I've spent quite some time in OSX Terminal, WSL (Linux Sybsystem for Windows), PowerShell, Linux terminal itself. One of my key requirements is the ability to use auto-complete on tab for eg file and foldernames. (Autocomplete is when you hit tab to automatically complete the file or folder name you are typing.)

In OSX by default, tab completion is beautiful, but case sensitive. And I happen to suck at remembering whether or not I capitalized my foldername. Some developers I know will simply try to keep all folder names lowercase to avoid this issue, but there is an easier way.

To get case insensitive autocomplete we need to make a change to the ~/.inputrc file. Inputrc is a file used to customize key-bindings defined by Readline, which is a library that handles reading input when using an interactive shell. By default this file doesn’t exist, so don’t be alarmed if you don’t see it.

This command will append the case insensitive setting to your ~/.inputrc file.

````bash
echo "set completion-ignore-case On" >> ~/.inputrc
````
