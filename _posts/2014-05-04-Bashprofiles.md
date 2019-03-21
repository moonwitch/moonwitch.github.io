---
layout: post
title: Bash Profile
category: projects
comments: true
tags: [cmd,linux,cli,bash]
---
Basically, yes - I am one of those people. With one of those people, I mean I am a CLI worker. While I often use GUIs, I feel quite at home in a text-only environment. In fact, this entire site minus the graphics is written with [Vi](http://www.wikipedia.com/vi). I do use [Sublime Text Editor](http://sublimetext.com), because it's handy. Because [Nano](http://en.wikipedia.org/wiki/Nano_(text_editor)) uses mouse input as well, it might be handier to use.

Know that if you ever ssh into a machine - a linux/unix/bsd server without GUI, as most are actually - you'll be working with Vi or nano.

Now, just because of that "No GUI" attitude, I've always struggled with Git (and thus Github and Bitbucket) in a GUI setting. I have no clue why, but for some reason every single commit went wrong. It drove me mad, so CLI it was.

{% highlight bash linenos %}
$ git init
$ git remote add origin https://github.com/user/repo.git
$ git add files-that-where-editted
$ git commit -m "commit message"
$ git push
{% endhighlight %}

Anyhow, here's my bash_profile

{% gist 10641553 install.sh %}
