---
title: "Automating the Boring Stuff at Home: A DevOps Approach to ADHD Life"
description: "How applying CI/CD principles, triggers, and monitoring can help manage household executive function load for neurodivergent brains."
date: "2026-06-14"
lastmod: "2026-06-14"
categories:
  - "tech"
tags:
  - "adhd"
  - "automation"
  - "devops"
  - "productivity"
  - "smart-home"
comments: true
draft: true
---

<!-- Tech / dev write-up. Lead with the problem, then the fix, then why it works. -->

In my day job, I build pipelines. I set up triggers so that when code changes, a series of automated events happens without me having to remember a single step. We do this in DevOps because humans are unreliable narrators and even worse at repetitive tasks.

As it turns out, "unreliable at repetitive tasks" is also a pretty good definition of my ADHD brain. 

For years, I felt like a failure because I couldn't remember to move the laundry to the dryer or pay a recurring bill on time. Then it clicked: I was trying to run my home life with manual deployments. I needed a CI/CD pipeline for my house.

## The Problem: The Executive Function Tax

The "tax" of being neurodivergent is the amount of energy you spend just *remembering* to do the basic maintenance of being alive. Every "Oh, I should do that" is a process running in the background, eating up your RAM until the whole system hangs.

## The Fix: Building the Home Pipeline

I started looking at my chores through the lens of **Triggers**, **Actions**, and **Monitoring**.

### 1. The 'Laundry Pipeline' (Trigger & Notification)
**Problem:** The wet laundry stays in the machine for three days because I forget it exists the moment the door closes.
**The Fix:** A smart plug with power-monitoring. 
**The Logic:** 
- `Trigger`: Power usage drops below 2W for more than 5 minutes.
- `Action`: Send a notification to my phone (and my wife's) saying "The laundry is ready for the next stage."
- `Result`: I don't have to remember the time; the machine tells me when it's done.

### 2. The 'Bill-Pay CronJob' (Scheduling)
**Problem:** "I'll pay that tonight" is a lie I tell myself daily.
**The Fix:** Automation and Direct Debits (obviously), but for the things that can't be automated, I use a 'Dead Man's Switch'.
**The Logic:**
- I use a recurring task in a shared app that *screams* at me until I check it off. If I haven't done it by the 'due date', it escalates (notifies my wife). Peer review works for code; it works for bills too.

### 3. 'Smart Home' as a Monitoring Dashboard
**Problem:** Leaving the lights on, the door unlocked, or the heating at 22°C all night.
**The Fix:** A "Sleep Mode" trigger.
**The Logic:**
- `Trigger`: One specific button press by the bed.
- `Actions`: Turn off all downstairs lights, lock the front door, drop the thermostat to 16°C, and turn on the white noise machine.
- `Monitoring`: If the front door is still unlocked at 11 PM, my phone gets a critical alert.

## Why it Works

This isn't just about being a "geek." It's about **offloading state**. 

When I know a system is monitoring the house, I don't have to use my limited executive function to scan for problems. When I know a notification will find me, I don't have to keep a mental timer running for the laundry. 

In DevOps, we automate to reduce "toil." In ADHD life, we automate to reduce the cognitive load that leads to burnout. 

## The Takeaway

If you're a neurodivergent engineer, you already have the skills to make your life easier. Stop trying to "try harder" and start building better pipelines. Your brain deserves a break from the manual labor of existing.

What's one "toil" in your house that you could automate today?
