---
title: Git Branching; the basics
date: 2020-02-21
comments: true
tags:
  - git
  - opensource
  - shell
categories:
  - articles
draft: false
---

### Intro

Git isn't as complex as it seems; once you get the hang of it. But it can be daunting, I admit to that. So let me explain the basics to you, so you too can jump in and use Git in a team.

#### First rule of Git-club is:

***Never work on `main`; always use a branch to work on features and issues.***
Why this matters? Because `main` is your holy grail, your production.

#### Second rule of Git-club is:

Commit messages matter - a lot.
This is so you know what happened and especially when. It allows you to roll back a commit if needed.

Learning both rules the hard way is how I came to see their importance. It caused me a lot of headache, so I'll try to spare you the same. I will assume you've already set up your Git configuration, and that you've cloned your local repository or initialized it and pushed it to remote. If this isn't the case; you can find out how to do that [here](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html).

### Branching

Because branching effectively creates a copy of your local version of `main`, it's best to make sure your local copy is up-to-date.

1. Make sure you're on `main`.

   ```
   git checkout main
   ```

2. Get the most recent version of `main`.

   ```
   git fetch
   git merge
   ```

> You can do this in one go as well. `pull` is a `fetch` and a `merge` combined.
>
> ```
> git pull
> ```

3. Creating your branch and switching to it. In this step you only create a _local_ branch, you haven't pushed it to remote yet.

   ```
   git branch descriptive_branchname
   git checkout descriptive_branchname
   ```

   > Shorthand for this step is:
   >
   > ```
   > git checkout -b descriptive_branchname
   > ````

4. Making your changes to your local new branch, adding them to the staging area - that's how we call it when you prepare your files to be committed.

   - Adding 2 files

     ````
     git add yourfile1 yourfile2
     ````

   - Add just one file

     ```
     git add onefile
     ```

   - Add all changes in one go (Not recommended, makes future references harder.)

     ```
     git add .
     ```

5. Creating a commit, adding a description to what happened in the changes files. The `-m` switch allows you to enter a message in-line. It's fast and easy; if you do a commit without `-m` your text editor will open for the message to be entered there.

   ```
   git commit -m 'A description of what changed.'
   ```

6. Finally; adding our local new branch to the remote.

   ```
   git push --set-upstream origin descriptive_branchname
   ```

   _Note: This step lets Git know where your local branch is on the remote; next pushes you no longer need to add the `--set-upstream`. It is also possible to configure your local Git installation to do this for you every time._

   ```
   git config --global push.default upstream
   ```

   > A shorter version of this is:
   >
   > ```
   > git push -u origin descriptive_branchname
   > ```

At this point, you can happily work on your changes, do some bug fixing. Just remember to commit often, a push isn't needed every single time. Every time you push to your branch, you'll be prompted by Gitlab to create a merge request. It looks like this:

```
...
remote: To create a merge request for descriptive_branchname, visit:
remote:   https://gitlab.com/projectname/merge_requests/new?merge_request%5Bsource_branch%5D=descriptive_branchname
```

> It is possible to raise a merge request from the command line as well; by using _push options_. To find out more, visit the relevant page over at [Gitlab](https://docs.gitlab.com/ee/user/project/push_options.html#push-options-for-merge-requests)

Once you've completed working in your branch and you're ready to merge it into `main`, go on and raise a Merge Request. You can opt to do it via the provided link or using push options as I've said.

There; that's all there is to it. Working with Git for version control has some immense benefits and I wouldn't want to work without having it in place. 
