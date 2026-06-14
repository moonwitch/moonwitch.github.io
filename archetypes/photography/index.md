---
title: "{{ replace .Name "-" " " | title }}"
description: ""
categories:
  - photography
tags: []
date: "{{ now.Format "2006-01-02" }}"
lastmod: "{{ now.Format "2006-01-02" }}"
comments: true
draft: true
# Page bundle: drop the images next to this index.md and list them here.
resources:
  - src: "*.jpg"
    title: ""
---

<!-- Photo set. The story behind the frames, if there is one. -->
