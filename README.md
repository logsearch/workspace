# Logsearch WorkSpace

## Purpose
To provide a workspace containing all the configuration, source code and dependancies for for operating and developing a Logsearch cluster.  

Using this workspace you can easily:

* Launch a test Logsearch cluster (in a local Vagrant VM or a remote EC2 VM)
* Deploy and administer a production multi-VM Logsearch cluster - using configuration as code
* Develop and customise the Logsearch components and make your own Logsearch release

## Getting started

### Single user local Vagrant VM

0. You need to have installed:
    * Git 1.8+
    * Vagrant 1.6.5+
    * VirtualBox 4.3.18+
    * A SSH client
0. Launch a Vagrant VM (This downloads [a custom Vagrant box of approx 1.4GB in size from AWS S3](https://github.com/Logsearch/workspace/blob/master/Vagrantfile#L12))

        git clone https://github.com/Logsearch/workspace ~/Logsearch-workspace
        cd ~/Logsearch-workspace
        vagrant up
          
0. SSH into your workspace
    * Using the default SSH client on Mac: `vagrant ssh`
    * Using a customised SSH client (eg, Kitty for Windows), you can get the SSH settings using `vagrant ssh-config`

0. Perform one of the common Logsearch Workspace tasks, eg:
    * [Launch your own test Logsearch cluster](http://www.logsearch.io/docs/boshrelease/getting-started/deploying-logsearch.html)
    * [Administer an existing Logsearch cluster](http://www.logsearch.io/docs/workspace/administer-logsearch-cluster.html)
    * [Develop & deploy a new Log Parsing filter](http://www.logsearch.io/docs/workspace/develop-a-logsearch-filter.html)

#### Multi-user VM on EC2

You can run multiple Logsearch Workspaces on a single VM (running inside your datacentre).  

This simplifies setup & maintenance of the Logsearch Workspace for team members, especially if they use Windows or have poor internet connections

This VM is also a good location to host your Continuous Integration build agents, or Chatbots that need to interact with your Logsearch infrastructure.

See [How to setup a Multi-User Logsearch Workspace](http://www.logsearch.io/docs/workspace/setup-multi-user-logsearch-workspace.html) for details.

## Further documentation

See the [Documentation](docs/README.md) for more examples of things you can do with the Logsearch Workspace
## Copyright and License

Copyright 2014 City Index Ltd.  Licensed under [Apache License 2.0](./LICENSE)
