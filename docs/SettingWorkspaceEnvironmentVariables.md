---
title: "Setting Workspace Environment Variables"
---

When you first setup your workspace, you might be greated with the following warnings at login:


    WARNING: Environment var: AWS_ACCESS_KEY_ID is not set.  You won't be able to interact with your AWS account. 
    WARNING: Environment var: AWS_SECRET_ACCESS_KEY is not set.  You won't be able to interact with your AWS account. 
    WARNING: Environment var: GIT_AUTHOR_NAME is not set.  You won't be able to commit changes to Git. 
    WARNING: Environment var: GIT_AUTHOR_EMAIL is not set.  You won't be able to commit changes to Git.

If you want to interact with git repos or AWS via the `git` and `aws` cli tools you will need to set these environment values.

There are 3 ways to do this:

### 0.  When using a local Vagrant VM

Vagrant manually copies matching environment variables from your local environment; so if these are already set you don't have to do anything.  All you need to do is set these in your local environment, and from a new terminal run `vagrant provision` once.

Horray!

### 1.  The simple way

You can hardcode workspace environment variables in `~/.env`

Using `~/.env-sample` as a template, create `~/.env` with your settings, and run `source ~/.bash_profile` (or logout and back in again)

### 2.  The "correct" way

You probably already have these env vars set in your local workstation's environment.  If so, then you can just forward them on to the workspace environment using SSH.

If you are using standard SSH, you can do so by adding the following to `~/.ssh/config`

         Host workspace.logsearch.io
           ForwardAgent yes
           SendEnv AWS_* GIT_*

where `workspace.logsearch.io` is the name of your Workspace host.  Next time you `ssh workspace.logsearch.io` your env vars will come with you.

This method is slightly more secure and convienient.