---
title: "Create Logsearch Workspace box"
---

To (manually) create a readily provisioned Logsearch Workspace Vagant box you need:

0. You need to have installed:
    * Git 1.8+
    * SSH
    * Vagrant 1.6+
0. Toggle the Vagrantfile base box settings and start the VM:
    * `vagrant destroy`
    * comment the `logsearch-workspace` config.vm.box setting in favor of the `cloudfoundry/bosh-lite` one
    * `vagrant up`
0. Install stemcell and latest logsearch-boshrelease

    vagrant ssh
    cd ~/environments/local/test/
    bosh upload stemcell https://s3.amazonaws.com/bosh-jenkins-artifacts/bosh-stemcell/warden/bosh-stemcell-388-warden-boshlite-ubuntu-trusty-go_agent.tgz
    bosh upload release https://s3.amazonaws.com/logsearch-boshrelease/releases/logsearch-17.tgz

0. Cleanup the system:
    
    sudo -i
    /root/shrink_vagrant_box_for_packaging

0. Create and upload the new Vagrant box:
    * `vagrant package`
    * rename/upload the resulting box for distribution via the `ci-logsearch` S3 bucket with a `vagrant/boxes/` prefix
0. Update the Vagrantfile base box settings:
    * comment the `cloudfoundry/bosh-lite` config.vm.box setting in favor of the `logsearch-workspace` one (update the VM name as appropriate)
    * commit the updated Vagrantfile to record the box version change
