# Administer LogSearch Cluster

Your LogSearch Workspace facilitates a "configuration as code" approach to managing "production" LogSearch clusters.

We recommend you create a private repo to hold configuration and deployment scripts for your environments.  

Clone this into the `~/environments` folder inside your workspace, eg:

     git clone git@github.com:cityindex/labs-operations.git ~/environments/cityindex

We recommend that you group everything related to an organisation in its own folder, everything related to an environemnt in its own folder, and everything related to a specific deployment in a folder below that.  For example, 

    ~/environments/
        cityindex/             # Everything related to the cityindex organisation
            live/              # Everything related to the live environment
                aws-vpc/
                bosh/
                logsearch/     # Config for the live logsearch cluster
                cf/
            test/
                aws-vpc/       # Config and scripts for setting up the test AWS VPC
                bosh/
                logsearch/
                cf/            # Config for the test Cloud Foundry cluster             

The LogSearch Workspace includes the `bosh` cli tool for interacting with your LogSearch clusters.  Inside the Workspace `bosh` is configured read its config from the current directory.  We recommend that you store a `.bosh_config` targetting each environment inside the environment's folder.

This means that you can change which environment you are targetting by simply changing your current directory.

For example

    cd ~/environments/local/test   
    bosh vms                  # Will list the deployments and VMs running in your local test environment

    cd ~/environments/cityindex/test   
    bosh vms                  # Will list the deployments and VMs running in the City Index Test environment


 To target a specific cluster, use `bosh`'s `-d` parameter

    cd ~/environments/local/test   
    bosh -d logsearch/manifest.yml deploy  # Deploys changes to your local test environments' LogSearch cluster

    cd ~/environments/cityindex/test   
    bosh -d logsearch/manifest.yml deploy  # Deploys changes to the City Index Test environment's LogSearch cluster

You can get further help on available bosh commands using:

    bosh help --all #Lists all commands available
    bosh help ssh   #Gets help on all the "ssh" commands

Further documentation on BOSH and its concepts can be found at [http://docs.cloudfoundry.org/bosh/](http://docs.cloudfoundry.org/bosh/)