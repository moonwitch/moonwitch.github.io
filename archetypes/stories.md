---
title: "{{ replace .Name "-" " " | title }}"
date: "{{ now.Format "2006-01-02" }}"
layout: stories
categories: 
  - stories
series:
  - "{{ replace .Name "-" " " | title }}"
---