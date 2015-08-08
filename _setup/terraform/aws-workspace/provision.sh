#!/bin/bash
echo "Provisioning..."

sudo apt-get update
sudo apt-get -y install git

echo "Mounting persistent disk as as /workspaces..."
# Create partition and format the persistent disk if not already formatted
sudo file -s /dev/xvdf | grep ext4 > /dev/null
if (($? != 0)); then
    echo "Creating ext4 filesystem on persistent disk"
    sudo mkfs.ext4 /dev/xvdf
fi

sudo mkdir -p /workspaces

mount | grep /workspaces
if (($? != 0)); then
    sudo mount /dev/xvdf /workspaces
fi

echo "Relocating all user home dirs to /workspaces..."
# TODO

echo "Installing logsearch-workspace dependancies..."
# HEY! WE NEED THE TODO BRANCH HERE SINCE THERE IS A ISSUE IN THE INSTALL_DEPENDANCIES SCTIPT.
sudo git clone -b todo https://github.com/logsearch/workspace /tmp/workspace
sudo /tmp/workspace/_setup/runtime/install_dependancies
sudo rm -rf /tmp/workspace


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
