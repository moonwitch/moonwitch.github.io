---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
weight: 50
images: ["{{ .Name | urlize }}.jpg"]
categories: [""]
---