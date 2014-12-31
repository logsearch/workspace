---
title: "Create LogSearch Workspace box"
---

To (manually) create a readily provisioned LogSearch Workspace Vagant box you need:

0. You need to have installed:
    * Git 1.8+
    * SSH
    * Vagrant 1.6+
0. Toggle the Vagrantfile base box settings and start the VM:
    * `vagrant destroy`
    * comment the `logsearch-workspace` config.vm.box setting in favor of the `cloudfoundry/bosh-lite` one
    * `vagrant up`
0. SSH in to cleanup the system:
    * `vagrant ssh`
    * remove credentials and shrink disk
	```bash
	# clean any credentials persisted eventually
	rm ~/.env
	# Zero out the free space to save space in the final image
	# Ignore no space left on device error
	dd if=/dev/zero of=/EMPTY bs=1M || true
	rm -f /EMPTY
	```
0. Create and upload the new Vagrant box:
    * `vagrant package`
    * rename/upload the resulting box for distribution via the `ci-logsearch` S3 bucket with a `vagrant/boxes/` prefix
0. Update the Vagrantfile base box settings:
    * comment the `cloudfoundry/bosh-lite` config.vm.box setting in favor of the `logsearch-workspace` one (update the VM name as appropriate)
    * commit the udpated Vagrantfile to record the box version change
