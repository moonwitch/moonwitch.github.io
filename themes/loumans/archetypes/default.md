---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
thumbnail: "path/thumbnail.jpg"
draft: true
images: ["{{ .Name | urlize }}.jpg"]
categories: [""]
tags: [""]
---
