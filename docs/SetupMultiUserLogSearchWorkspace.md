To setup the LogSearch Workspace VM you need:

0. You need to have installed:
    * Git 1.8+
    * SSH
    * AWS credentials
0. Launch a server running within your VPC:
    * Using a LogSearch Workspace AMI (`eu-west-1 : ami-4c4cfe3b`)
    * Size: m3.xlarge
    * Security group: One with full access to other machines in your VPC
    * With a persistent volume mounted under `/workspaces`
    * With DNS name - eg: `workspace.logsearch.io`
0. SSH in and become `root`

        git clone https://github.com/logsearch/workspace /root/logsearch-workspace
        cd /root/logsearch-workspace
        _setup/runtime/install_dependancies
        
0. Add a remote workspace
    * You need the username and SSH public key for the workspace user
    * SSH in and become `root`
    
            cd /root/logsearch-workspace
            WORKSPACE_USERNAME=janesmith WORKSPACE_PUBLIC_KEY='ssh-rsa xxxx' WORKSPACE_HOMEDIRS=/workspaces _setup/runtime/add_new_workspace

    * The user (ie, `janesmith`) should now be able to SSH into their new workspace using 
    
            ssh janesmith@workspace.logsearch.io