# LogSearch Operations

## Purpose

This repository contains configuration, code and documentation for developing and running LogSearch clusters

## Requirements

* Vagrant 1.6.5+
* VirtualBox 4.3.18+

## Setup

* Rename the sample `.bosh_config.default` files to `.bosh_config` using `find . -name .bosh_config.default | sed -e "p;s/.default//" | xargs -n2 cp`
* `bin/launch_local_runtime-environments` - takes about 10 min to spin up a boot2docker VM and initialise some docker containers

## Working with BOSH
* Connect to the environment's VPN (eg, vpn.meta.logsearch.io or vpn.cityindex.logsearch.io)
* `bin/connect_bosh-cli_runtime-environment` - SSH's into the [bosh-cli] runtime environment container
* `cd` into the environment, eg `cd meta` - this targets that environment's BOSH director
* Login to the director `bosh login` (should only have to do this once)
* Run BOSH commands; eg `bosh -d logsearch/deploy_manifest.yml ssh` or `bosh vms --vitals`

## Further documentation

Please see README.md files inside each subfolder for more specific details
