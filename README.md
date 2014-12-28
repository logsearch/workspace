# LogSearch WorkSpace

## Purpose
To provide a workspace containing all the configuration, source code and dependancies for for operating and developing a LogSearch cluster.  

Using this workspace you can easily:

* Launch a test LogSearch cluster (in a local Vagrant VM or a remote EC2 VM)
* Deploy and administer a production multi-VM LogSearch cluster - using configuration as code
* Develop and customise the LogSearch components and make your own LogSearch release

## Getting started

### Single user local Vagrant VM

0. You need to have installed:
    * Git 1.8+
    * Vagrant 1.6.5+
    * VirtualBox 4.3.18+
    * A SSH client
0. Launch a Vagrant VM (This downloads [a custom Vagrant box of approx 800MB in size from AWS S3](https://github.com/logsearch/workspace/blob/master/Vagrantfile#L12))

        git clone https://github.com/logsearch/workspace ~/logsearch-workspace
        cd ~/logsearch-workspace
        vagrant up
          
0. SSH into your workspace
    * Using the default SSH client on Mac: `vagrant ssh`
    * Using a customised SSH client (eg, Kitty for Windows), you can get the SSH settings using `vagrant ssh-config`

0. Perform one of the common LogSearch Workspace tasks, eg:
    * [Launch your own test LogSearch cluster](docs/LaunchTestLogSearchCluster.md)
    * [Administer an existing LogSearch cluster](docs/AdministerLogSearchCluster.md)
    * [Develop & deploy a new Log Parsing filter](docs/DevelopAndDeployALogParsingFilter.md)

#### Multi-user VM on EC2

You can run multiple LogSearch Workspaces on a single VM (running inside your datacentre).  

This simplifies setup & maintenance of the LogSearch Workspace for team members, especially if they use Windows or have poor internet connections

This VM is also a good location to host your Continuous Integration build agents, or Chatbots that need to interact with your LogSearch infrastructure.

See [How to setup a Multi-User LogSearch Workspace](docs/SetupMultiUserLogSearchWorkspace.md) for details.

## Further documentation

See the [Documentation](docs/README.md) for more examples of things you can do with the LogSearch Workspace
## Copyright and License

Copyright 2014 City Index Ltd.  Licensed under [Apache License 2.0](./LICENSE)
