---
title: "Launch a local test LogSearch cluster"
---

The LogSearch Workspace contains a copy of bosh-lite, which enables you to deploy a local LogSearch cluster using Linux Containers rather than actual VMs.

This provides a quick and cheap way to simluate running a LogSearch cluster

0. SSH into your workspace
0. Navigate to the local test environment

        cd ~/environments/local/test

0. Ensure the `bosh-warden-boshlite-ubuntu-trusty-go_agent` stemcell exists

        bosh stemcells
        
    If you see `No stemcells`, then you need to upload the latest `warden-boshlite-ubuntu-trusty` stemcell:
    
        bosh upload stemcell http://bosh-jenkins-artifacts.s3.amazonaws.com/bosh-stemcell/warden/latest-bosh-stemcell-warden.tgz
        
    You should see:
    
        Using remote stemcell `http://bosh-jenkins-artifacts.s3.amazonaws.com/bosh-stemcell/warden/latest-bosh-stemcell-warden.tgz'

        Director task 1
          Started update stemcell
          Started update stemcell > Downloading remote stemcell. Done (00:03:48)
          Started update stemcell > Extracting stemcell archive. Done (00:00:04)
          Started update stemcell > Verifying stemcell manifest. Done (00:00:00)
          Started update stemcell > Checking if this stemcell already exists. Done (00:00:00)
          Started update stemcell > Uploading stemcell bosh-warden-boshlite-ubuntu-trusty-go_agent/389 to the cloud. Done (00:00:14)
          Started update stemcell > Save stemcell bosh-warden-boshlite-ubuntu-trusty-go_agent/389 (cd1b3001-26cf-4755-4d52-34f43298655a). Done (00:00:00)
             Done update stemcell (00:04:06)

        Task 1 done

        Started        2014-12-11 14:49:19 UTC
        Finished  2014-12-11 14:53:25 UTC
        Duration  00:04:06

        Stemcell uploaded and created.
        
0. Ensure the latest version of the `logsearch` bosh release exists

        bosh releases
        
    If you see `No releases`, then you need to upload the latest `logsearch` bosh release:
    
        bosh upload release https://s3-eu-west-1.amazonaws.com/ci-logsearch/releases/logsearch/logsearch-17.tgz
    
    you should see:
    
        Using remote release `https://s3-eu-west-1.amazonaws.com/ci-logsearch/releases/logsearch/logsearch-17.tgz'
        
        Director task 2
          Started downloading remote release > Downloading remote release. Done (00:02:07)
        
          Started extracting release > Extracting release. Done (00:00:02)
        
          Started verifying manifest > Verifying manifest. Done (00:00:00)
        
          Started resolving package dependencies > Resolving package dependencies. Done (00:00:00)
        
          Started creating new packages
          Started creating new packages > collectd/426c5cb42ff5a326e539aef22f7d14526a02c1be. Done (00:00:00)
          Started creating new packages > elasticsearch/e866cba047ff7ce1f31e3bcfce0762e13c2f47cf. Done (00:00:00)
          Started creating new packages > java7/c04c102fd6c411f867dc44ee65279dd47eb5c8a0. Done (00:00:00)
          Started creating new packages > logstash/5e1a6fd74024db3c4923397f71da1c71a0cb51d3. Done (00:00:01)
          Started creating new packages > logstash-forwarder/2f966c5caa729f165636c69ee9acd2ead524183b. Done (00:00:00)
          Started creating new packages > nginx/07fa264094f0ebb55bcc9990578d9cc159748dc0. Done (00:00:00)
          Started creating new packages > python/356d0ec8645d158e9d1a517c2fd071762d43429d. Done (00:00:01)
          Started creating new packages > redis/cd861700c83a544b6d0bba3b620017d22cf0d726. Done (00:00:00)
             Done creating new packages (00:00:02)
        
          Started creating new jobs
          Started creating new jobs > api/fca1f4acb43451d401d242b9d9b9a2efae79bbbe. Done (00:00:00)
          Started creating new jobs > archiver/69b68098e3654c1ec25cd5a16ea9ff6112ceb02e. Done (00:00:00)
          Started creating new jobs > collectd/8e0bf1ae5d65c2a9858aba54c1d138f1745f9c9f. Done (00:00:00)
          Started creating new jobs > elasticsearch/8e330f94fcc1aa08f5ba3a74ddb144d7785606b7. Done (00:00:00)
          Started creating new jobs > ingestor_archiver/ec3f65762d09bff74efd1d07d3f866f7f1c8dc30. Done (00:00:00)
          Started creating new jobs > ingestor_lumberjack/592fb6bfa0a970127d0d6ede46e4c5f4884f2871. Done (00:00:00)
          Started creating new jobs > ingestor_relp/11901b7a163992d010119c87d4226bee144c0cb0. Done (00:00:00)
          Started creating new jobs > ingestor_syslog/e59ffc07e601b88d9552b5858db7ebd14c1a26df. Done (00:00:00)
          Started creating new jobs > log_parser/1d1d3af02ba5e9316b922580845c4552afda9646. Done (00:00:00)
          Started creating new jobs > logstash_forwarder/05710c0c57f2d1eb0e26ca4ad81f7ad41b65c1a1. Done (00:00:00)
          Started creating new jobs > queue/ad4acaba83cb6c5ce57a1aa9a590230b683d5dae. Done (00:00:00)
             Done creating new jobs (00:00:00)
        
          Started release has been created > logsearch/17. Done (00:00:00)
        
        Task 2 done
        
        Started     2014-12-11 14:57:45 UTC
        Finished  2014-12-11 14:59:56 UTC
        Duration  00:02:11
        
        Release uploaded        

    
0.  Deploy your local test LogSearch cluster

        bosh -n -d logsearch/manifest.yml deploy
    
    you should see:

        Processing deployment manifest
        ------------------------------
        Getting deployment properties from director...
        Compiling deployment manifest...
        
        Deploying
        ---------
        Deployment name: `manifest.yml'
        Director name: `Bosh Lite Director'
        
        Director task 3
          Started preparing deployment
          Started preparing deployment > Binding deployment. Done (00:00:00)
          Started preparing deployment > Binding releases. Done (00:00:00)
          Started preparing deployment > Binding existing deployment. Done (00:00:00)
          Started preparing deployment > Binding resource pools. Done (00:00:00)
          Started preparing deployment > Binding stemcells. Done (00:00:00)
          Started preparing deployment > Binding templates. Done (00:00:00)
          Started preparing deployment > Binding properties. Done (00:00:00)
          Started preparing deployment > Binding unallocated VMs. Done (00:00:00)
          Started preparing deployment > Binding instance networks. Done (00:00:00)
             Done preparing deployment (00:00:00)
                   Started preparing package compilation > Finding packages to compile. Done (00:00:00)
                   Started compiling packages
          Started compiling packages > redis/cd861700c83a544b6d0bba3b620017d22cf0d726
          Started compiling packages > logstash/5e1a6fd74024db3c4923397f71da1c71a0cb51d3
             Done compiling packages > redis/cd861700c83a544b6d0bba3b620017d22cf0d726 (00:00:21)
          Started compiling packages > python/356d0ec8645d158e9d1a517c2fd071762d43429d
             Done compiling packages > logstash/5e1a6fd74024db3c4923397f71da1c71a0cb51d3 (00:00:22)
          Started compiling packages > nginx/07fa264094f0ebb55bcc9990578d9cc159748dc0. Done (00:00:42)
          Started compiling packages > java7/c04c102fd6c411f867dc44ee65279dd47eb5c8a0. Done (00:00:12)
          Started compiling packages > elasticsearch/e866cba047ff7ce1f31e3bcfce0762e13c2f47cf. Done (00:00:05)
             Done compiling packages > python/356d0ec8645d158e9d1a517c2fd071762d43429d (00:01:40)
          Started compiling packages > collectd/426c5cb42ff5a326e539aef22f7d14526a02c1be. Done (00:00:48)
             Done compiling packages (00:02:49)
                 
          Started preparing dns > Binding DNS. Done (00:00:00)
        
          Started creating bound missing vms
          Started creating bound missing vms > warden/0
          Started creating bound missing vms > warden/1
          Started creating bound missing vms > warden/2
          Started creating bound missing vms > warden/3
          Started creating bound missing vms > warden/4
          Started creating bound missing vms > warden/5
             Done creating bound missing vms > warden/3 (00:00:02)
             Done creating bound missing vms > warden/1 (00:00:02)
             Done creating bound missing vms > warden/2 (00:00:02)
             Done creating bound missing vms > warden/4 (00:00:03)
             Done creating bound missing vms > warden/5 (00:00:04)
             Done creating bound missing vms > warden/0 (00:00:04)
             Done creating bound missing vms (00:00:04)
        
          Started binding instance vms
          Started binding instance vms > api/0
          Started binding instance vms > ingestor/0
          Started binding instance vms > queue/0
          Started binding instance vms > log_parser/0
          Started binding instance vms > elasticsearch_az1/0
          Started binding instance vms > elasticsearch_az2/0
             Done binding instance vms > ingestor/0 (00:00:00)
             Done binding instance vms > api/0 (00:00:00)
             Done binding instance vms > queue/0 (00:00:00)
             Done binding instance vms > elasticsearch_az1/0 (00:00:00)
             Done binding instance vms > elasticsearch_az2/0 (00:00:00)
             Done binding instance vms > log_parser/0 (00:00:00)
             Done binding instance vms (00:00:00)
        
          Started preparing configuration > Binding configuration. Done (00:00:01)
        
          Started updating job api > api/0 (canary). Done (00:00:43)
          Started updating job ingestor > ingestor/0 (canary). Done (00:00:47)
          Started updating job queue > queue/0 (canary). Done (00:00:38)
          Started updating job log_parser > log_parser/0 (canary). Done (00:00:49)
          Started updating job elasticsearch_az1 > elasticsearch_az1/0 (canary). Done (00:00:44)
          Started updating job elasticsearch_az2 > elasticsearch_az2/0 (canary). Done (00:00:44)
        
        Task 3 done
        
        Started   2014-12-11 15:55:39 UTC
        Finished  2014-12-11 16:00:09 UTC
        Duration  00:04:30
        
        Deployed `manifest.yml' to `Bosh Lite Director'

0.  Mappings
    * Run `bosh vms` to see the IPs assigned to each VM in the deployment:

            Deployment `vagrant-logsearch'
            
            Director task 27
            
            Task 27 done
            
            +---------------------+---------+---------------+---------------+
            | Job/index           | State   | Resource Pool | IPs           |
            +---------------------+---------+---------------+---------------+
            | api/0               | running | warden        | 10.244.10.2   |
            | elasticsearch_az1/0 | running | warden        | 10.244.10.122 |
            | elasticsearch_az2/0 | running | warden        | 10.244.10.126 |
            | ingestor/0          | running | warden        | 10.244.10.6   |
            | log_parser/0        | running | warden        | 10.244.10.118 |
            | queue/0             | running | warden        | 10.244.10.10  |
            +---------------------+---------+---------------+---------------+
           
            VMs total: 6
    
    * From inside the Workspace you can access these IPs directly, eg: `curl 10.244.10.2`

            {
              "status" : 200,
              "name" : "api/0",
              "version" : {
                "number" : "1.2.1",
                "build_hash" : "6c95b759f9e7ef0f8e17f77d850da43ce8a4b364",
                "build_timestamp" : "2014-06-03T15:02:52Z",
                "build_snapshot" : false,
                "lucene_version" : "4.8"
              },
              "tagline" : "You Know, for Search"
             }

    * Port mappings have been set up between the Workspace's external IP and these internal IPs.  You can see what these are using `cat ~/port_mappings.txt` :
    
            Port Mappings:
              192.168.50.4:10080 -> 10.244.10.2:80
              192.168.50.4:10443 -> 10.244.10.6:443
     
      Thus, from outside the Workspace (eg, in your browser), the same curl request can be made using `192.168.50.4:10080`
      
0.  Ship in data
      * @todo - point to scripts that inject some test data

0.  Browse to Kibana
      * Kibana is installed on the API node.  You can access it via a browser external to the Workspace using `http://$workspace_external_ip:$port/_plugin/kibana`, eg `http://192.168.50.4:10080/_plugin/kibana`