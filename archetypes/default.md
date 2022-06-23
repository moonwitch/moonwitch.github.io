---
title: {{ .TranslationBaseName | replaceRE "^([[:digit:]]+-){3}" "" | replaceRE "-" " " | title }}
categories:
  - blog
tags:
  - 
date: "{{ now.Format "2006-01-02" }}"
lastmod: "{{ now.Format "2006-01-02" }}"
lang: en
comments: true
draft: false
---