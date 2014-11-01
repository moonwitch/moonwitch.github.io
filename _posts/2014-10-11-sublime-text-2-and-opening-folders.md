---
layout: post
image: optional
title: Sublime Text 3 and opening folders
date: 2014-10-11
category: blog
tag: quicktip
comments: true
---

One of my petpeeves with an otherwise amazing editor is the fact that I can not open Folders as projects from the command line or from within Finder. However it's easily fixed with a small service you can easily create or a symlink. So let's do that today. Just follow along.

## First off: Finder.app and GUI

1. Open Automator
2. Choose _Service_ as template.
3. Select *files or folders* in *Finder.app*.
4. Drag over "Run Shell Script" from your Library and set it up as follows:
    Shell : "/bin/bash"
    Pass input : "as arguments"

    ```bash
    /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -n "$@"
    ```

    Like so:
    ![Automator preview]({{ site.baseurl }}/public/assets/img/open-folder-in-sublime-640x260.jpg)
5. Save the service, and note that the name you give it when saving is what it will be called in the context menu. If Sublime opens a blank window, toggle the sidebar, and you will see the documents.

## Console side of things

This is fairly simple actually; most of already have a symlink to use sublime from the terminal anyhow. If you have a symlink setup already - you're done. If not; just do the following:

Open Terminal and run this command
{% highlight bash %}
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /bin/subl
{% endhighlight %}

You will now be able to open files and folders from the command line.
{% highlight bash %}
#opening a file
subl filename
#opening a folder
cd foldername
subl .
{% endhighlight %}
