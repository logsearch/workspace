# LogSearch Operations

## Purpose

This repository contains a virtual workspace for developing and running LogSearch clusters

## Requirements

* Vagrant 1.6.5+
* VirtualBox 4.3.18+ OR an AWS account

## Setup

* Rename `.env-sample` to `.env` and fill in your credentials
* Launch the virtual workspace - `bin/launch-local` or `bin/launch-aws`
	* On first run this takes about 10 - 30 min to spin up a VM and initialise some docker containers

## Working with BOSH
* Connect to the environment's VPN (eg, vpn.meta.logsearch.io or vpn.cityindex.logsearch.io)
* `bin/connect_bosh-cli_runtime-environment` - SSH's into the [bosh-cli] runtime environment container
* `cd` into the environment, eg `cd meta` - this targets that environment's BOSH director
* Login to the director `bosh login` (should only have to do this once)
* Run BOSH commands; eg `bosh -d logsearch/deploy_manifest.yml ssh` or `bosh vms --vitals`

## Developing

* Documentation is available at `http://$VM_IP:8080`
* Kibana is available at `http://$VM_IP:8000`

## Further documentation

Please see README.md files inside each subfolder for more specific details
