# Logsearch WorkSpace

## Purpose
To provide a workspace containing all the configuration, source code and dependancies for for operating and developing a Logsearch cluster.  

Using this workspace you can easily:

* Launch a test Logsearch cluster (in a local Vagrant VM or a remote EC2 VM)
* Deploy and administer a production multi-VM Logsearch cluster - using configuration as code
* Develop and customise the Logsearch components and make your own Logsearch release

## Getting started

### Single user local Vagrant VM

You can run a single user local Logsearch Workspace VM using Vagrant.  This is the easiest way to get started with Logsearch.
See [Lauch local Vagrant based Logsearch Workspace VM](http://www.logsearch.io/docs/workspace/launch-local-vagrant-logsearch-workspace.html) for details.

#### Multi-user VM on EC2

You can run multiple Logsearch Workspaces on a single VM (running inside your datacentre).  

This simplifies setup & maintenance of the Logsearch Workspace for team members, especially if they use Windows or have poor internet connections

This VM is also a good location to host your Continuous Integration build agents, or Chatbots that need to interact with your Logsearch infrastructure.

See [How to setup a Multi-User Logsearch Workspace](http://www.logsearch.io/docs/workspace/setup-multi-user-logsearch-workspace.html) for details.

## Further documentation

See the [Documentation](http://www.logsearch.io/docs/workspace) for more examples of things you can do with the Logsearch Workspace

## Copyright and License

Copyright 2014-2015 City Index Ltd.  Licensed under [Apache License 2.0](./LICENSE)
