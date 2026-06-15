---
title: "Removing the 'Discover' Button in Edge"
description: "A quick PowerShell tip to remove the Bing 'Discover' sidebar button from Microsoft Edge."
date: "2023-03-15"
lastmod: "2026-06-14"
comments: true
tags:
  - "powershell"
  - "edge"
  - "windows"
categories:
  - "tech"
draft: false
---

## Removing the 'Discover' button in Edge

Removing that pesky 'Discover' button is easy as pie!

Open a Powershell window as admin and do the following:

```powershell
New-Item –Path "HKLM:\SOFTWARE\Policies\Microsoft" –Name Edge
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "HubsSidebarEnabled" -Value 0  -PropertyType "DWORD"
```

Then in Edge, go to 'edge://policy' and hit "Reload Policies".

Voila :)
