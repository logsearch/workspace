# LogSearch WorkSpace

## Purpose

To provide a workspace for operating and developing a LogSearch cluster.  

The workspace is comprised of a local folder (where you can edit), a remote folder (when you can run things) and tooling to help you sync between both.  The local portion can be run anywhere which has a BASH shell; the remote must be a BOSH lite Ubuntu 14.04 server (either running under Vagrant, or within your cloud; eg EC2)

## Setup

### Remote

#### EC2 server

_We recommend that you have one member of your team set up a remote server in EC2 for everyone to share_

* An server running within your VPC based a LogSearch Workspace AMI (eg: ami-4c4cfe3b )
  * size: m3.xlarge
  * security group: One with full access to other machines in your VPC
* SSH in and become `root`
```
sudo -i
git clone https://github.com/logsearch/workspace /root/logsearch-workspace
cd /root/logsearch-workspace
_setup_remote/install_dependancies
```
* Add a remote workspace for each team member
```
cd /root/logsearch-workspace
WORKSPACE_USERNAME="usernaxxxxxx" WORKSPACE_PUBLIC_KEY="ssh-rsa AAAxxxx" _setup_remote/setup_workspace
```

#### Vagrant server

* Install
	* Vagrant 1.6.5+
	* VirtualBox 4.3.18+
* Launch a Vagrant machine
```
git clone https://github.com/logsearch/workspace ~/logsearch-workspace
cd ~/logsearch-workspace/_setup_remote
vagrant up
```
* SSH in and become `root`
```
vagrant ssh
sudo -i
```
* Add a remote workspace for each team member
```
cd /root/logsearch-workspace
WORKSPACE_USERNAME="usernaxxxxxx" WORKSPACE_PUBLIC_KEY="ssh-rsa AAAxxxx" _setup_remote/setup_workspace
```

### Local 

* You will need the remote connection details obtained during the adding of your remote workspace above
* Open a BASH shell.  (ie, the Mac OSX terminal or the shell that comes bundled with SourceTree on Windows)

```
git clone https://github.com/logsearch/workspace ~/logsearch-workspace
cd ~/logsearch-workspace
bin/check_dependancies # Fix any dependancy errors reported
bin/connect 
bin/init
```
