---
title: {{ .TranslationBaseName | replaceRE "^([[:digit:]]+-){3}" "" | replaceRE "-" " " | title }}
description: ""
categories:
  - notes
tags:
  - quick-tip
date: "{{ now.Format "2006-01-02" }}"
lastmod: "{{ now.Format "2006-01-02" }}"
comments: true
draft: true
---

<!-- Short write / quick tip. Keep it tight: the thing, and how to do it. -->
