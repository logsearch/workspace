#!/bin/bash
echo "Provisioning!"

apt-get -y install git

exit 0

git clone https://github.com/logsearch/workspace /root/logsearch-workspace
 cd /root/logsearch-workspace
 _setup/runtime/install_dependancies