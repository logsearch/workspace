---
title: "Launch local Vagrant based Logsearch Workspace VM"
---

The instructions below walk through setting up a local Logsearch Workspace VM based on Vagrant and Virtualbox:

0. You need to have installed:
    * Git 1.8+
    * Vagrant 1.6.5+
    * VirtualBox 4.3.18+
    * A SSH client

0. Installing above dependancies 
    * on Windows

        We recommend you use the [Chocolatey](https://chocolatey.org/) package manager to install the above dependancies on  Windows
        
        Open an _Administrative PowerShell_ prompt and:
        
            iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')) # Installs Chocolatey
            choco install git         # Installs git AND a ssh client
            choco install virtualbox  # Installs VirtualBox
            choco install vagrant     # Installs Vagrant

    * on Mac OSX

        We recommend you use the [Homebrew](http://brew.sh/) package manager to install the above dependancies on Mac
        
        Open an terminal and:
        
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" # Installs HomeBrew
            brew install git                       #installs git
            brew install caskroom/cask/brew-cask   # homebrew-cask manages binary apps with HomeBrew
            brew cask install virtualbox           # Installs VirtualBox
            brew cask install vagrant              # Installs Vagrant

0. Launch a Vagrant VM (This downloads [a custom Vagrant box of approx 1.4GB in size from AWS S3](https://github.com/Logsearch/workspace/blob/master/Vagrantfile#L12))

    * _NB! On Windows you must run this from an Administrative console prompt_

        git clone https://github.com/logsearch/workspace ~/logsearch-workspace
        cd ~/logsearch-workspace
        vagrant up
          
0. SSH into your workspace
    * Using the default SSH client: `vagrant ssh`
    * In case you want to use a custom SSH client (eg, Putty/Kitty on Windows), you can get the SSH settings needed using ``vagrant ssh-config`
    * You should see something like:

             $ vagrant ssh
             Welcome to Ubuntu 14.04 LTS (GNU/Linux 3.13.0-37-generic x86_64)
             
              * Documentation:  https://help.ubuntu.com/
             +-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+
             |L|o|g|S|e|a|r|c|h| |W|o|r|k|s|p|a|c|e|
             +-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+
             
             ├── bin
             │   └── setup_sub_projects               <--- run this to populate your environments/ and src/ folders
             ├── environments                         <--- configuration for the environments you manage goes here
             │   └── labs-operations                  
             ├── src                                  <--- LogSearch source code goes here
             │   ├── docs
             │   ├── kibana                           
             │   ├── kibana-status-diagram-plugin
             │   ├── logsearch-filters-internal
             │   └── logsearch-website
             
             See the README.md in each sub project for further instructions.
             
             Loading ENV variables from ~/.env
             Port Mappings:
                 192.168.50.4:10080 -> 10.244.10.2:80
                 192.168.50.4:10443 -> 10.244.10.6:443
             [logsearch workspace] ~ ▸ 

         
  