---
title: "Restoring a logsearch workspace deployment after rebooting"
---

A limitation of the Logsearch workspace is that test deployments in it stop working after the VM has been rebooted (or sometimes if the host has been to sleep).

Run `bosh vms` to check whether this has happened to your deployment.  If you see lots of references to `unresponsive agent` then this has happened to you.


			[logsearch workspace] ~/environments/local/test ▸ bosh vms
			Deployment `vagrant-logsearch'

			Director task 23

			Task 23 done

			+-----------------+--------------------+---------------+-----+
			| Job/index       | State              | Resource Pool | IPs |
			+-----------------+--------------------+---------------+-----+
			| unknown/unknown | unresponsive agent |               |     |
			| unknown/unknown | unresponsive agent |               |     |
			| unknown/unknown | unresponsive agent |               |     |
			| unknown/unknown | unresponsive agent |               |     |
			| unknown/unknown | unresponsive agent |               |     |
			| unknown/unknown | unresponsive agent |               |     |
			+-----------------+--------------------+---------------+-----+

			VMs total: 6

Fortunately its easy to fix using the `bosh cloudcheck` command.  Just choose to `Recreate VM using last known apply spec`, as shown below:

			[logsearch workspace] ~/environments/local/test ▸ bosh -d logsearch/manifest.yml cloudcheck
			Performing cloud check...

			Processing deployment manifest
			------------------------------

			Director task 24
			  Started scanning 6 vms
			  Started scanning 6 vms > Checking VM states. Done (00:00:10)
			  Started scanning 6 vms > 0 OK, 0 unresponsive, 6 missing, 0 unbound, 0 out of sync. Done (00:00:00)
			     Done scanning 6 vms (00:00:10)

			  Started scanning 2 persistent disks
			  Started scanning 2 persistent disks > Looking for inactive disks. Done (00:00:00)
			  Started scanning 2 persistent disks > 2 OK, 0 missing, 0 inactive, 0 mount-info mismatch. Done (00:00:00)
			     Done scanning 2 persistent disks (00:00:00)

			Task 24 done

			Started		2015-02-11 10:17:08 UTC
			Finished	2015-02-11 10:17:18 UTC
			Duration	00:00:10

			Scan is complete, checking if any problems found...

			Found 6 problems

			Problem 1 of 6: VM with cloud ID `0a1649f5-99d3-4b23-5453-cedcd766a9c1' missing.
			  1. Ignore problem
			  2. Recreate VM using last known apply spec
			  3. Delete VM reference (DANGEROUS!)
			Please choose a resolution [1 - 3]: 2

			Problem 2 of 6: VM with cloud ID `51f6a6ad-7663-47e1-4117-bb05f9338f25' missing.
			  1. Ignore problem
			  2. Recreate VM using last known apply spec
			  3. Delete VM reference (DANGEROUS!)
			Please choose a resolution [1 - 3]: 2

			Problem 3 of 6: VM with cloud ID `54613ebf-370b-4cf7-68c1-8a44d043ee3d' missing.
			  1. Ignore problem
			  2. Recreate VM using last known apply spec
			  3. Delete VM reference (DANGEROUS!)
			Please choose a resolution [1 - 3]: 2

			Problem 4 of 6: VM with cloud ID `7925df53-f1a2-4814-5dbf-226512ec7a27' missing.
			  1. Ignore problem
			  2. Recreate VM using last known apply spec
			  3. Delete VM reference (DANGEROUS!)
			Please choose a resolution [1 - 3]: 2

			Problem 5 of 6: VM with cloud ID `ded7d845-2a56-4910-5bdb-9d72ddd997ab' missing.
			  1. Ignore problem
			  2. Recreate VM using last known apply spec
			  3. Delete VM reference (DANGEROUS!)
			Please choose a resolution [1 - 3]: 2

			Problem 6 of 6: VM with cloud ID `7363328d-6b1f-4959-5544-075eaef55683' missing.
			  1. Ignore problem
			  2. Recreate VM using last known apply spec
			  3. Delete VM reference (DANGEROUS!)
			Please choose a resolution [1 - 3]: 2

			Below is the list of resolutions you've provided
			Please make sure everything is fine and confirm your changes

			  1. VM with cloud ID `0a1649f5-99d3-4b23-5453-cedcd766a9c1' missing.
			     Recreate VM using last known apply spec

			  2. VM with cloud ID `51f6a6ad-7663-47e1-4117-bb05f9338f25' missing.
			     Recreate VM using last known apply spec

			  3. VM with cloud ID `54613ebf-370b-4cf7-68c1-8a44d043ee3d' missing.
			     Recreate VM using last known apply spec

			  4. VM with cloud ID `7925df53-f1a2-4814-5dbf-226512ec7a27' missing.
			     Recreate VM using last known apply spec

			  5. VM with cloud ID `ded7d845-2a56-4910-5bdb-9d72ddd997ab' missing.
			     Recreate VM using last known apply spec

			  6. VM with cloud ID `7363328d-6b1f-4959-5544-075eaef55683' missing.
			     Recreate VM using last known apply spec

			Apply resolutions? (type 'yes' to continue): yes
			Applying resolutions...
						
			Director task 25
			  Started applying problem resolutions
			  Started applying problem resolutions > missing_vm 5: Recreate VM using last known apply spec. Done (00:00:16)
			  Started applying problem resolutions > missing_vm 4: Recreate VM using last known apply spec. Done (00:00:14)
			  Started applying problem resolutions > missing_vm 6: Recreate VM using last known apply spec. Done (00:00:20)
			  Started applying problem resolutions > missing_vm 8: Recreate VM using last known apply spec. Done (00:00:09)
			  Started applying problem resolutions > missing_vm 7: Recreate VM using last known apply spec. Done (00:00:22)
			  Started applying problem resolutions > missing_vm 9: Recreate VM using last known apply spec. Done (00:00:17)
			     Done applying problem resolutions (00:01:38)

			Task 25 done

			Started		2015-02-11 10:17:27 UTC
			Finished	2015-02-11 10:19:05 UTC
			Duration	00:01:38
			Cloudcheck is finished
