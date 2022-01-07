---
title: "Icinga2 Notifications: 101"
date: 2019-11-14
comments: true
tags: 
  - icinga
  - devops
  - work
categories:
  - articles
draft: false
---

## Problem

- Email notifications in Icinga2 for your hostgroup
- You can't find a quick 'n dirty method

## Pre-Reqs

- Installation of Icinga2
- Configured some hosts, hostgroups and services

## So how do I do it?

### Making sure mail works

1. Install ssmtp 

```bash
yum install ssmtp
```

2. Disable postfix and stop the service 

```bash
systemctl disable postfix
systemctl stop postfix
```

3. Configure your 'finger' information. 

```bash
chfn -f name-you-want-as-displayname loginname
```

4. Configure ssmtp

```bash
#
# /etc/ssmtp.conf -- a config file for sSMTP sendmail.
#
# Recipient for all mail to userids < 100
root=postmaster

# The place where the mail goes.
mailhub=smtp.example.com

# Where will the mail seem to come from? This would be the part after the @
RewriteDomain=example.com

# Set this to never rewrite the "From:" line (unless not given) and to
# use that address in the "from line" of the envelope.
FromLineOverride=YES
```

5. Start and enable service

```bash
systemctl enable ssmtp
systemctl start ssmtp
```

6. Test this

```bash
echo "Hello, this is a test" | mail -s "Test" someone@example.com
```

### Configure icinga2 user (and usergroups)

By default, icinga2 comes with a UserGroup called 'icingaadmins'.
Any user of this group will receive email notifications if the icinga2 host itself has issues. 

_Please note that an icinga2 user is not necessarily an icingaweb2 login user. This is a whole different topic._

A simple user looks like this:

```
object UserGroup "icingaadmins" {
	display_name = "Icinga 2 Admin Group"
}
 
object User "TestUser" {
  display_name = "A Name"
  groups = [ "icingaadmins" ]
  email = "someone@example.com"
  period = "24x7"
  states = [ OK, Warning, Critical, Unknown ]
  types = [ Problem, Recovery ]
}
```
If you need more information on the attributes just have a look at the [documentation](http://docs.icinga.org/icinga2/latest/doc/module/icinga2/toc#!/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2-first-steps#users-conf).

### Assign Notification to Service and User

But if you want mails for hosts or services you have to use assign (see [documentation](http://docs.icinga.org/icinga2/latest/doc/module/icinga2/toc#!/icinga2/latest/doc/module/icinga2/chapter/monitoring-basics#using-apply)). 

In the following example I assign the command mail-service-notification (defined in "/etc/icinga2/scripts/") to every service, which runs on the host named "Host1". A notification will only be sent once a state change is detected. ("interval = 0")

  ```
  apply Notification "Notify-Test" to Service {
    command = "mail-service-notification"
    users = ["TestUser"]
    interval = 0
    assign where service.host_name == "Host1"
  }
  ```
