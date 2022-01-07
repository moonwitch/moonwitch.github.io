---
title: HP Envy on Linux
date: 2019-09-27
comments: true
tags: 
  - linux
  - printing
categories:
  - articles
draft: false
---

In my previous iteration - this is in the days of RH7.3 and thereabouts - printing and scanning under Linux was a big issue for me. There were no drivers, nothing. You looked for working setups and bought a printer based on that. 

Fast-forward to now; I've rekindled with Linux, this time Manjaro. Much to my surprise, in my 'gone' years I noticed that there were a few welcome additions to my linux life. 

- Steam works; many games actually work.
- Printing worked out-of-the-box.
- Scanning did not. 
- I still favor xfce with open-box

My printer at home is an HP Envy Photo 6232; a fairly decent printer although printing photos leaves them orange-y in tint. Whole different rage on that topic coming in at some point. Printing worked fine, but scanning caused my printer to go insane and have all lights flickering.

Turns out that sane has commented out the exact printer I have. So if you have the same printer I do; follow along. 

### Installation

1. Install cups for printing, http://www.cups.org/
For Arch-based distro's
```
sudo pacman -S cups
```
2. Start cups
For Arch-based distro's
```
systemctl start cupsd
```
2. Install HPLIP drivers, http://hplip.sourceforge.net
For Arch-based distro's
```
sudo pacman -S hplip
```
3. Install Sane for scanning, http://www.sane-project.org
For Arch-based distro's
```
sudo pacman -S sane-backends
```
4. Install XSane for scanning, http://www.xsane.org/
For Arch-based distro's
```
sudo pacman -S xsane
```

### Configuration
This step was essential, without it - my physical printer would just crash when I tried to scan.

1. For Arch-based distro's
```
sudo vim /etc/sane.d/dll.conf
```
2. Uncomment the last line: `hpaio`
3. Save this file
4. Try scanning with xsane as non-root


