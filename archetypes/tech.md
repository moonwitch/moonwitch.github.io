---
title: {{ .TranslationBaseName | replaceRE "^([[:digit:]]+-){3}" "" | replaceRE "-" " " | title }}
description: ""
categories:
  - tech
tags: []
date: "{{ now.Format "2006-01-02" }}"
lastmod: "{{ now.Format "2006-01-02" }}"
comments: true
draft: true
---

<!-- Tech / dev write-up. Lead with the problem, then the fix, then why it works. -->
