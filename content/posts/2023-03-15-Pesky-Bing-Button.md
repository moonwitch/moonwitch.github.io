---
title: Removing the 'Discover' button in Edge
categories:
  - blog
tags:
  - powershell
  - howto
date: 2023-03-15T00:00:00.000Z
lastmod: 2023-03-15T00:00:00.000Z
language: en
comments: true
draft: false
published: true
---
## Removing the 'Discover' button in Edgeo

Removing that pesky 'Discover' button is easy as pie!

Open a Powershell window as admin and do the following: 

```powershell
New-Item –Path "HKLM:\SOFTWARE\Policies\Microsoft" –Name Edge
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "HubsSidebarEnabled" -Value 0  -PropertyType "DWORD"
```

Then in Edge, go to 'edge://policy' and hit "Reload Policies". 

Voila :) 

