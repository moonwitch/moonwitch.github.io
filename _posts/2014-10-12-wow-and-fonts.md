---
layout: post
image: optional
title: WoW and fonts
date: 2014-10-12
category: blog
comments: true
tags: [wow, games]
---
After about 4hrs of dry-coding some of my addons; tweaking my UI (and yes, Jurian, I blame you.) I suddenly found myself gobsmacked. A lot of names weren't properly being displayed. They looked cut off and in the chat I lost whatever they'd say. 

Since I had been working on [DefineInteresting](http://github.com/moonwitch/DefineInteresting) and had changed some globals - yes, I know - bad, I assumed it was within my code. 30min and a lot of swearing later; I realized that /who netted the same results - and you can't edit those. Turns out -- FONTS! Yes, fonts.

I had changed the default fonts in WoW to look a bit nicer; but failed at noticing that some fonts didn't have all the accented letters. And turns out that messes up the UI pretty bad. 

So off I go; finding a new font yet again.
