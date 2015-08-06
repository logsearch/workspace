#!/bin/bash
echo "Provisioning..."

sudo apt-get update
sudo apt-get -y install git

echo "Mounting persistent disk as as /workspaces..."
# TODO: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html

echo "Relocating all user home dirs to /workspaces..."
# TODO

echo "Installing logsearch-workspace dependancies..."
# TODO: 
# sudo git clone https://github.com/logsearch/workspace /root/logsearch-workspace
# sudo /root/logsearch-workspace/_setup/runtime/install_dependancies

echo "Provision user accounts"
# TODO - not sure this step can/should be automated
# steps:
# sudo /root/logsearch-workspace/_setup/runtime/add_new_workspace --workspace-tenant-number 1 --workspace-username mrdavidlaing --workspace-public-key 'ssh-rsa AAAAB3...' --workspace-homedirs /workspaces
# sudo /root/logsearch-workspace/_setup/runtime/add_new_workspace --workspace-tenant-number 2 --workspace-username user2 ...

echo "Installing CF..."
# TODO
echo "Adding ip-tables routes to CF"
# PRIVATE_IP=????
# sudo iptables -t nat -A PREROUTING -p tcp -d $PRIVATE_IP --dport 80 -j DNAT --to 10.244.0.34:80
# sudo iptables -t nat -A PREROUTING -p tcp -d $PRIVATE_IP --dport 443 -j DNAT --to 10.244.0.34:443

# sudo iptables-save > /etc/iptables/rules.v4

echo "Installing Logsearch..."
# TODO

echo "=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo " "
echo "\o/ Provisioning completed!"
echo " |"
echo '/ \'