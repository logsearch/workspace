# LogSearch WorkSpace

## Purpose

This repository helps you setup a workspace for operating and developing a LogSearch cluster.  

The workspace can be hosted on a Mac OSX or Windows workstation (with a local Vagrant VM) or on an EC2 instance.

## Requirements

### Mac OSX workstation

* Vagrant 1.6.5+
* VirtualBox 4.3.18+
* Homebrew

### Windows workstation

* Vagrant 1.6.5+
* VirtualBox 4.3.18+
* SourceTree

### EC2 server

* An server running within your VPC based a LogSearch Workspace AMI (eg: ami-4c4cfe3b )
  * size: m3.xlarge
  * security group: One with full access to other machines in your VPC

## Setup

```
git clone https://github.com/logsearch/workspace
bin/init
```

## Further documentation

Please see README.md files inside each subfolder for more specific details
