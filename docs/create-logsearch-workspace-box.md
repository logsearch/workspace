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
    * comment out the
        *  _logsearch-workspace_ settings
            * `config.vm.box`
            * `config.vm.box_url`  
        * in favor of the _cloudfoundry/bosh-lite_ ones
            * `config.vm.box`
            * `config.vm.box_url`
    * `vagrant up`

0. Install stemcell and latest logsearch-boshrelease

        vagrant ssh
        cd ~/environments/local/test/
        bosh upload stemcell https://s3.amazonaws.com/bosh-jenkins-artifacts/bosh-stemcell/warden/bosh-stemcell-388-warden-boshlite    -ubuntu-trusty-go_agent.tgz
        bosh upload release https://s3.amazonaws.com/logsearch-boshrelease/releases/logsearch-17.tgz

0. Cleanup the system:
    
        sudo -i
        /root/shrink_vagrant_box_for_packaging

0. Create and upload the new Vagrant box:
    * `exit` back to host prompt
    * `vagrant package`
    * rename/upload the resulting box for distribution 
    * Upload to the the `ci-logsearch` S3 bucket inside the a `vagrant/boxes/` "folder".  Ensure the resulting file is publically accessible.

0. Update the Vagrantfile base box settings:
    * comment out the
        *  _cloudfoundry/bosh-lite_ settings
            * `config.vm.box`
            * `config.vm.box_url`
        *  in favor of the _logsearch-workspace_ ones
            * `config.vm.box`
            * `config.vm.box_url`  

0. Commit the updated `Vagrantfile` to record the box version change

0.  "Success" looks similar to this:

        logsearch-workspace (       3) mrdavidlaing/Dev/logsearch-workspace$ vagrant destroy
            default: Are you sure you want to destroy the 'default' VM? [y/N] y
        ==> default: Forcing shutdown of VM...
        ==> default: Destroying VM and associated drives...
        ==> default: Pruning invalid NFS exports. Administrator privileges will be required...
        Password:
        ==> default: Running cleanup tasks for 'shell' provisioner...
        ==> default: Running cleanup tasks for 'shell' provisioner...
        ==> default: Running cleanup tasks for 'shell' provisioner...
        logsearch-workspace (       3) mrdavidlaing/Dev/logsearch-workspace$ vagrant up
        Bringing machine 'default' up with 'virtualbox' provider...
        ==> default: Importing base box 'cloudfoundry/bosh-lite'...
        ==> default: Matching MAC address for NAT networking...
        ==> default: Checking if box 'cloudfoundry/bosh-lite' is up to date...
        ==> default: Setting the name of the VM: logsearch-workspace_default_1422348692149_34307
        ==> default: Clearing any previously set network interfaces...
        ==> default: Preparing network interfaces based on configuration...
            default: Adapter 1: nat
            default: Adapter 2: hostonly
            default: Adapter 3: hostonly
        ==> default: Forwarding ports...
            default: 22 => 2222 (adapter 1)
        ==> default: Running 'pre-boot' VM customizations...
        ==> default: Booting VM...
        ==> default: Waiting for machine to boot. This may take a few minutes...
            default: SSH address: 127.0.0.1:2222
            default: SSH username: vagrant
            default: SSH auth method: private key
            default: Warning: Connection timeout. Retrying...
            default: 
            default: Vagrant insecure key detected. Vagrant will automatically replace
            default: this with a newly generated keypair for better security.
            default: 
            default: Inserting generated public key within guest...
            default: Removing insecure key from the guest if its present...
            default: Key inserted! Disconnecting and reconnecting using new SSH key...
        ==> default: Machine booted and ready!
        ==> default: Checking for guest additions in VM...
        ==> default: Setting hostname...
        ==> default: Configuring and enabling network interfaces...
        ==> default: Installing NFS client...
        ==> default: Exporting NFS shared folders...
        ==> default: Preparing to edit /etc/exports. Administrator privileges will be required...
        ==> default: Mounting NFS shared folders...
        ==> default: Mounting shared folders...
            default: /vagrant => /Users/mrdavidlaing/Dev/logsearch-workspace
        ==> default: Running provisioner: shell...
            default: Running: inline script
        ==> default: Running provisioner: shell...
            default: Running: inline script
        ==> default: Installing docker...
        ==> default: Executing: gpg --ignore-time-conflict --no-options --no-default-keyring --homedir /tmp/tmp.d6187ERkZ0 --no-auto-        check-trustdb --trust-model always --keyring /etc/apt/trusted.gpg --primary-keyring /etc/apt/trusted.gpg --keyserver         hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
        ==> default: gpg: requesting key A88D21E9 from hkp server keyserver.ubuntu.com
        ==> default: gpg: key A88D21E9: public key "Docker Release Tool (releasedocker) <docker@dotcloud.com>" imported
        ==> default: gpg: Total number processed: 1
        ==> default: gpg:               imported: 1  (RSA: 1)
        ==> default: Ign http://security.ubuntu.com trusty-security InRelease
        ==> default: Hit http://security.ubuntu.com trusty-security Release.gpg
        ==> default: Hit http://security.ubuntu.com trusty-security Release
        ==> default: Hit http://security.ubuntu.com trusty-security/main Sources
        ==> default: Hit http://security.ubuntu.com trusty-security/restricted Sources
        ==> default: Hit http://security.ubuntu.com trusty-security/universe Sources
        ==> default: Hit http://security.ubuntu.com trusty-security/multiverse Sources
        ==> default: Hit http://security.ubuntu.com trusty-security/main amd64 Packages
        ==> default: Hit http://security.ubuntu.com trusty-security/restricted amd64 Packages
        ==> default: Hit http://security.ubuntu.com trusty-security/universe amd64 Packages
        ==> default: Hit http://security.ubuntu.com trusty-security/multiverse amd64 Packages
        ==> default: Ign http://us.archive.ubuntu.com trusty InRelease
        ==> default: Hit http://security.ubuntu.com trusty-security/main i386 Packages
        ==> default: Hit http://security.ubuntu.com trusty-security/restricted i386 Packages
        ==> default: Hit http://security.ubuntu.com trusty-security/universe i386 Packages
        ==> default: Hit http://security.ubuntu.com trusty-security/multiverse i386 Packages
        ==> default: Hit http://security.ubuntu.com trusty-security/main Translation-en
        ==> default: Hit http://security.ubuntu.com trusty-security/multiverse Translation-en
        ==> default: Hit http://security.ubuntu.com trusty-security/restricted Translation-en
        ==> default: Ign http://us.archive.ubuntu.com trusty-updates InRelease
        ==> default: Hit http://security.ubuntu.com trusty-security/universe Translation-en
        ==> default: Ign http://us.archive.ubuntu.com trusty-backports InRelease
        ==> default: Hit http://us.archive.ubuntu.com trusty Release.gpg
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates Release.gpg
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports Release.gpg
        ==> default: Hit http://us.archive.ubuntu.com trusty Release
        ==> default: Get:1 https://get.docker.com docker InRelease
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates Release
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports Release
        ==> default: Hit http://us.archive.ubuntu.com trusty/main Sources
        ==> default: Hit http://us.archive.ubuntu.com trusty/restricted Sources
        ==> default: Hit http://us.archive.ubuntu.com trusty/universe Sources
        ==> default: Ign https://get.docker.com docker InRelease
        ==> default: Hit http://us.archive.ubuntu.com trusty/multiverse Sources
        ==> default: Hit http://us.archive.ubuntu.com trusty/main amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty/restricted amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty/universe amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty/multiverse amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty/main i386 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty/restricted i386 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty/universe i386 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty/multiverse i386 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty/main Translation-en
        ==> default: Hit http://us.archive.ubuntu.com trusty/multiverse Translation-en
        ==> default: Get:2 https://get.docker.com docker Release
        ==> default: Hit http://us.archive.ubuntu.com trusty/restricted Translation-en
        ==> default: Hit http://us.archive.ubuntu.com trusty/universe Translation-en
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/main Sources
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/restricted Sources
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/universe Sources
        ==> default: Get:3 https://get.docker.com docker/main amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/multiverse Sources
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/main amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/restricted amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/universe amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/multiverse amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/main i386 Packages
        ==> default: Get:4 https://get.docker.com docker/main i386 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/restricted i386 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/universe i386 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/multiverse i386 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/main Translation-en
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/multiverse Translation-en
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/restricted Translation-en
        ==> default: Hit http://us.archive.ubuntu.com trusty-updates/universe Translation-en
        ==> default: Get:5 https://get.docker.com docker/main Translation-en_US
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/main Sources
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/restricted Sources
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/universe Sources
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/multiverse Sources
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/main amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/restricted amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/universe amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/multiverse amd64 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/main i386 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/restricted i386 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/universe i386 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/multiverse i386 Packages
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/main Translation-en
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/multiverse Translation-en
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/restricted Translation-en
        ==> default: Hit http://us.archive.ubuntu.com trusty-backports/universe Translation-en
        ==> default: Ign http://us.archive.ubuntu.com trusty/main Translation-en_US
        ==> default: Ign http://us.archive.ubuntu.com trusty/multiverse Translation-en_US
        ==> default: Ign http://us.archive.ubuntu.com trusty/restricted Translation-en_US
        ==> default: Ign http://us.archive.ubuntu.com trusty/universe Translation-en_US
        ==> default: Ign https://get.docker.com docker/main Translation-en_US
        ==> default: Ign https://get.docker.com docker/main Translation-en
        ==> default: Fetched 7,471 B in 13s (537 B/s)
        ==> default: Reading package lists...
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following extra packages will be installed:
        ==> default:   aufs-tools cgroup-lite git git-man liberror-perl lxc-docker-1.4.1
        ==> default: Suggested packages:
        ==> default:   git-daemon-run git-daemon-sysvinit git-doc git-el git-email git-gui gitk
        ==> default:   gitweb git-arch git-bzr git-cvs git-mediawiki git-svn
        ==> default: The following NEW packages will be installed:
        ==> default:   aufs-tools cgroup-lite git git-man liberror-perl lxc-docker lxc-docker-1.4.1
        ==> default: 0 upgraded, 7 newly installed, 0 to remove and 127 not upgraded.
        ==> default: Need to get 7,864 kB of archives.
        ==> default: After this operation, 36.7 MB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/universe aufs-tools amd64 1:3.2+20130722-1.1 [92.3 kB]
        ==> default: Get:2 http://us.archive.ubuntu.com/ubuntu/ trusty/main liberror-perl all 0.17-1.1 [21.1 kB]
        ==> default: Get:3 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main git-man all 1:1.9.1-1ubuntu0.1 [698 kB]
        ==> default: Get:4 https://get.docker.com/ubuntu/ docker/main lxc-docker-1.4.1 amd64 1.4.1 [4,420 kB]
        ==> default: Get:5 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main git amd64 1:1.9.1-1ubuntu0.1 [2,627 kB]
        ==> default: Get:6 http://us.archive.ubuntu.com/ubuntu/ trusty/main cgroup-lite all 1.9 [3,918 B]
        ==> default: Get:7 https://get.docker.com/ubuntu/ docker/main lxc-docker amd64 1.4.1 [2,090 B]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 7,864 kB in 14s (543 kB/s)
        ==> default: Selecting previously unselected package aufs-tools.
        ==> default: (Reading database ... 54297 files and directories currently installed.)
        ==> default: Preparing to unpack .../aufs-tools_1%3a3.2+20130722-1.1_amd64.deb ...
        ==> default: Unpacking aufs-tools (1:3.2+20130722-1.1) ...
        ==> default: Selecting previously unselected package liberror-perl.
        ==> default: Preparing to unpack .../liberror-perl_0.17-1.1_all.deb ...
        ==> default: Unpacking liberror-perl (0.17-1.1) ...
        ==> default: Selecting previously unselected package git-man.
        ==> default: Preparing to unpack .../git-man_1%3a1.9.1-1ubuntu0.1_all.deb ...
        ==> default: Unpacking git-man (1:1.9.1-1ubuntu0.1) ...
        ==> default: Selecting previously unselected package git.
        ==> default: Preparing to unpack .../git_1%3a1.9.1-1ubuntu0.1_amd64.deb ...
        ==> default: Unpacking git (1:1.9.1-1ubuntu0.1) ...
        ==> default: Selecting previously unselected package cgroup-lite.
        ==> default: Preparing to unpack .../cgroup-lite_1.9_all.deb ...
        ==> default: Unpacking cgroup-lite (1.9) ...
        ==> default: Selecting previously unselected package lxc-docker-1.4.1.
        ==> default: Preparing to unpack .../lxc-docker-1.4.1_1.4.1_amd64.deb ...
        ==> default: Unpacking lxc-docker-1.4.1 (1.4.1) ...
        ==> default: Selecting previously unselected package lxc-docker.
        ==> default: Preparing to unpack .../lxc-docker_1.4.1_amd64.deb ...
        ==> default: Unpacking lxc-docker (1.4.1) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Processing triggers for ureadahead (0.100.0-16) ...
        ==> default: Setting up aufs-tools (1:3.2+20130722-1.1) ...
        ==> default: Setting up liberror-perl (0.17-1.1) ...
        ==> default: Setting up git-man (1:1.9.1-1ubuntu0.1) ...
        ==> default: Setting up git (1:1.9.1-1ubuntu0.1) ...
        ==> default: Setting up cgroup-lite (1.9) ...
        ==> default: cgroup-lite start/running
        ==> default: Setting up lxc-docker-1.4.1 (1.4.1) ...
        ==> default: docker start/running, process 6304
        ==> default: Processing triggers for ureadahead (0.100.0-16) ...
        ==> default: Setting up lxc-docker (1.4.1) ...
        ==> default: Processing triggers for libc-bin (2.19-0ubuntu6) ...
        ==> default: docker: Docker version 1.4.1, build 5bc2ff8
        ==> default: apparmor: installed
        ==> default: Installing curl
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following extra packages will be installed:
        ==> default:   libcurl3
        ==> default: The following NEW packages will be installed:
        ==> default:   curl
        ==> default: The following packages will be upgraded:
        ==> default:   libcurl3
        ==> default: 1 upgraded, 1 newly installed, 0 to remove and 126 not upgraded.
        ==> default: Need to get 295 kB of archives.
        ==> default: After this operation, 315 kB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libcurl3 amd64 7.35.0-1ubuntu2.3 [172 kB]
        ==> default: Get:2 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main curl amd64 7.35.0-1ubuntu2.3 [123 kB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 295 kB in 0s (340 kB/s)
        ==> default: (Reading database ... 55164 files and directories currently installed.)
        ==> default: Preparing to unpack .../libcurl3_7.35.0-1ubuntu2.3_amd64.deb ...
        ==> default: Unpacking libcurl3:amd64 (7.35.0-1ubuntu2.3) over (7.35.0-1ubuntu2.1) ...
        ==> default: Selecting previously unselected package curl.
        ==> default: Preparing to unpack .../curl_7.35.0-1ubuntu2.3_amd64.deb ...
        ==> default: Unpacking curl (7.35.0-1ubuntu2.3) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Setting up libcurl3:amd64 (7.35.0-1ubuntu2.3) ...
        ==> default: Setting up curl (7.35.0-1ubuntu2.3) ...
        ==> default: Processing triggers for libc-bin (2.19-0ubuntu6) ...
        ==> default: curl: curl 7.35.0 (x86_64-pc-linux-gnu) libcurl/7.35.0 OpenSSL/1.0.1f zlib/1.2.8 libidn/1.28 librtmp/2.3
        ==> default: git: git version 1.9.1
        ==> default: Installing bsdtar
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: Suggested packages:
        ==> default:   bsdcpio
        ==> default: The following NEW packages will be installed:
        ==> default:   bsdtar
        ==> default: 0 upgraded, 1 newly installed, 0 to remove and 126 not upgraded.
        ==> default: Need to get 47.8 kB of archives.
        ==> default: After this operation, 129 kB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/universe bsdtar amd64 3.1.2-7ubuntu2 [47.8 kB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 47.8 kB in 0s (129 kB/s)
        ==> default: Selecting previously unselected package bsdtar.
        ==> default: (Reading database ... 55170 files and directories currently installed.)
        ==> default: Preparing to unpack .../bsdtar_3.1.2-7ubuntu2_amd64.deb ...
        ==> default: Unpacking bsdtar (3.1.2-7ubuntu2) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Setting up bsdtar (3.1.2-7ubuntu2) ...
        ==> default: bsdtar: bsdtar 3.1.2 - libarchive 3.1.2
        ==> default: Installing spiff...
        ==> default:   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
        ==> default:                                  Dload  Upload   Total   Spent    Left  Speed
          0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
        100   399    0   399    0     0   1066      0 --:--:-- --:--:-- --:--:--  1069
          0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
          0 1301k    0     0    0     0      0      0 --:--:--  0:00:01 --:--:--     0
        ==> default: x spiff
         35 1301k   35  456k    0     0   172k      0  0:00:07  0:00
        ==> default: :02  0:00:05  233k
        100 1301k  100 1301k    0     0   419k      0  0:00:03  0
        ==> default: :00:03 --:--:--  542k
        ==> default: spiff: spiff version 1.0.3
        ==> default: Installing Mecurial
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following extra packages will be installed:
        ==> default:   libdrm-intel1 libdrm-nouveau2 libdrm-radeon1 libfontenc1 libgl1-mesa-dri
        ==> default:   libgl1-mesa-glx libglapi-mesa libice6 libllvm3.4 libpciaccess0 libsm6
        ==> default:   libtcl8.6 libtk8.6 libtxc-dxtn-s2tc0 libutempter0 libx11-xcb1 libxaw7
        ==> default:   libxcb-dri2-0 libxcb-dri3-0 libxcb-glx0 libxcb-present0 libxcb-shape0
        ==> default:   libxcb-sync1 libxcomposite1 libxdamage1 libxfixes3 libxi6 libxinerama1
        ==> default:   libxmu6 libxpm4 libxrandr2 libxshmfence1 libxt6 libxtst6 libxv1 libxxf86dga1
        ==> default:   libxxf86vm1 mercurial-common tcl tcl8.6 tk tk8.6 x11-utils xbitmaps xterm
        ==> default: Suggested packages:
        ==> default:   libglide3 qct vim emacs kdiff3 kdiff3-qt kompare meld tkcvs mgdiff
        ==> default:   python-mysqldb python-pygments python-openssl tcl-tclreadline mesa-utils
        ==> default:   xfonts-cyrillic
        ==> default: Recommended packages:
        ==> default:   wish
        ==> default: The following NEW packages will be installed:
        ==> default:   libdrm-intel1 libdrm-nouveau2 libdrm-radeon1 libfontenc1 libgl1-mesa-dri
        ==> default:   libgl1-mesa-glx libglapi-mesa libice6 libllvm3.4 libpciaccess0 libsm6
        ==> default:   libtcl8.6 libtk8.6 libtxc-dxtn-s2tc0 libutempter0 libx11-xcb1 libxaw7
        ==> default:   libxcb-dri2-0 libxcb-dri3-0 libxcb-glx0 libxcb-present0 libxcb-shape0
        ==> default:   libxcb-sync1 libxcomposite1 libxdamage1 libxfixes3 libxi6 libxinerama1
        ==> default:   libxmu6 libxpm4 libxrandr2 libxshmfence1 libxt6 libxtst6 libxv1 libxxf86dga1
        ==> default:   libxxf86vm1 mercurial mercurial-common tcl tcl8.6 tk tk8.6 x11-utils
        ==> default:   xbitmaps xterm
        ==> default: 0 upgraded, 46 newly installed, 0 to remove and 126 not upgraded.
        ==> default: Need to get 16.1 MB of archives.
        ==> default: After this operation, 81.9 MB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/main libpciaccess0 amd64 0.13.2-1 [20.4 kB]
        ==> default: Get:2 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libdrm-intel1 amd64 2.4.56-1~ubuntu1 [54.5 kB]
        ==> default: Get:3 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libdrm-nouveau2 amd64 2.4.56-1~ubuntu1 [13.7 kB]
        ==> default: Get:4 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libdrm-radeon1 amd64 2.4.56-1~ubuntu1 [23.3 kB]
        ==> default: Get:5 http://us.archive.ubuntu.com/ubuntu/ trusty/main libfontenc1 amd64 1:1.1.2-1 [15.6 kB]
        ==> default: Get:6 http://us.archive.ubuntu.com/ubuntu/ trusty/main libllvm3.4 amd64 1:3.4-1ubuntu3 [6,540 kB]
        ==> default: Get:7 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libgl1-mesa-dri amd64 10.1.3-0ubuntu0.3 [4,519 kB]
        ==> default: Get:8 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libglapi-mesa amd64 10.1.3-0ubuntu0.3 [21.0 kB]
        ==> default: Get:9 http://us.archive.ubuntu.com/ubuntu/ trusty/main libx11-xcb1 amd64 2:1.6.2-1ubuntu2 [9,426 B]
        ==> default: Get:10 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-dri2-0 amd64 1.10-2ubuntu1 [6,710 B]
        ==> default: Get:11 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-dri3-0 amd64 1.10-2ubuntu1 [5,118 B]
        ==> default: Get:12 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-glx0 amd64 1.10-2ubuntu1 [20.0 kB]
        ==> default: Get:13 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-present0 amd64 1.10-2ubuntu1 [5,254 B]
        ==> default: Get:14 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-sync1 amd64 1.10-2ubuntu1 [8,090 B]
        ==> default: Get:15 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxdamage1 amd64 1:1.1.4-1ubuntu1 [7,612 B]
        ==> default: Get:16 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxfixes3 amd64 1:5.0.1-1ubuntu1 [11.7 kB]
        ==> default: Get:17 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxshmfence1 amd64 1.1-2 [4,644 B]
        ==> default: Get:18 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxxf86vm1 amd64 1:1.1.3-1 [11.7 kB]
        ==> default: Get:19 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libgl1-mesa-glx amd64 10.1.3-0ubuntu0.3 [114 kB]
        ==> default: Get:20 http://us.archive.ubuntu.com/ubuntu/ trusty/main libice6 amd64 2:1.0.8-2 [47.0 kB]
        ==> default: Get:21 http://us.archive.ubuntu.com/ubuntu/ trusty/main libsm6 amd64 2:1.2.1-2 [18.1 kB]
        ==> default: Get:22 http://us.archive.ubuntu.com/ubuntu/ trusty/main libtcl8.6 amd64 8.6.1-4ubuntu1 [841 kB]
        ==> default: Get:23 http://us.archive.ubuntu.com/ubuntu/ trusty/main libtk8.6 amd64 8.6.1-3ubuntu2 [689 kB]
        ==> default: Get:24 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxt6 amd64 1:1.1.4-1 [185 kB]
        ==> default: Get:25 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxmu6 amd64 2:1.1.1-1 [53.8 kB]
        ==> default: Get:26 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxpm4 amd64 1:3.5.10-1 [38.3 kB]
        ==> default: Get:27 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxaw7 amd64 2:1.0.12-1 [168 kB]
        ==> default: Get:28 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-shape0 amd64 1.10-2ubuntu1 [5,654 B]
        ==> default: Get:29 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcomposite1 amd64 1:0.4.4-1 [7,714 B]
        ==> default: Get:30 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxi6 amd64 2:1.7.1.901-1ubuntu1 [31.9 kB]
        ==> default: Get:31 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxinerama1 amd64 2:1.1.3-1 [7,908 B]
        ==> default: Get:32 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxrandr2 amd64 2:1.4.2-1 [16.6 kB]
        ==> default: Get:33 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxtst6 amd64 2:1.2.2-1 [14.1 kB]
        ==> default: Get:34 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxv1 amd64 2:1.0.10-1 [10.3 kB]
        ==> default: Get:35 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxxf86dga1 amd64 2:1.1.4-1 [13.7 kB]
        ==> default: Get:36 http://us.archive.ubuntu.com/ubuntu/ trusty/main libtxc-dxtn-s2tc0 amd64 0~git20131104-1.1 [51.8 kB]
        ==> default: Get:37 http://us.archive.ubuntu.com/ubuntu/ trusty/main libutempter0 amd64 1.1.5-4build1 [8,366 B]
        ==> default: Get:38 http://us.archive.ubuntu.com/ubuntu/ trusty/universe mercurial-common all 2.8.2-1ubuntu1 [1,517 kB]
        ==> default: Get:39 http://us.archive.ubuntu.com/ubuntu/ trusty/universe mercurial amd64 2.8.2-1ubuntu1 [40.8 kB]
        ==> default: Get:40 http://us.archive.ubuntu.com/ubuntu/ trusty/main tcl8.6 amd64 8.6.1-4ubuntu1 [14.2 kB]
        ==> default: Get:41 http://us.archive.ubuntu.com/ubuntu/ trusty/main tcl amd64 8.6.0+6ubuntu3 [4,900 B]
        ==> default: Get:42 http://us.archive.ubuntu.com/ubuntu/ trusty/main tk8.6 amd64 8.6.1-3ubuntu2 [12.1 kB]
        ==> default: Get:43 http://us.archive.ubuntu.com/ubuntu/ trusty/main tk amd64 8.6.0+6ubuntu3 [3,192 B]
        ==> default: Get:44 http://us.archive.ubuntu.com/ubuntu/ trusty/main x11-utils amd64 7.7+1 [230 kB]
        ==> default: Get:45 http://us.archive.ubuntu.com/ubuntu/ trusty/main xbitmaps all 1.1.1-2 [28.1 kB]
        ==> default: Get:46 http://us.archive.ubuntu.com/ubuntu/ trusty/main xterm amd64 297-1ubuntu1 [665 kB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 16.1 MB in 15s (1,041 kB/s)
        ==> default: Selecting previously unselected package libpciaccess0:amd64.
        ==> default: (Reading database ... 55177 files and directories currently installed.)
        ==> default: Preparing to unpack .../libpciaccess0_0.13.2-1_amd64.deb ...
        ==> default: Unpacking libpciaccess0:amd64 (0.13.2-1) ...
        ==> default: Selecting previously unselected package libdrm-intel1:amd64.
        ==> default: Preparing to unpack .../libdrm-intel1_2.4.56-1~ubuntu1_amd64.deb ...
        ==> default: Unpacking libdrm-intel1:amd64 (2.4.56-1~ubuntu1) ...
        ==> default: Selecting previously unselected package libdrm-nouveau2:amd64.
        ==> default: Preparing to unpack .../libdrm-nouveau2_2.4.56-1~ubuntu1_amd64.deb ...
        ==> default: Unpacking libdrm-nouveau2:amd64 (2.4.56-1~ubuntu1) ...
        ==> default: Selecting previously unselected package libdrm-radeon1:amd64.
        ==> default: Preparing to unpack .../libdrm-radeon1_2.4.56-1~ubuntu1_amd64.deb ...
        ==> default: Unpacking libdrm-radeon1:amd64 (2.4.56-1~ubuntu1) ...
        ==> default: Selecting previously unselected package libfontenc1:amd64.
        ==> default: Preparing to unpack .../libfontenc1_1%3a1.1.2-1_amd64.deb ...
        ==> default: Unpacking libfontenc1:amd64 (1:1.1.2-1) ...
        ==> default: Selecting previously unselected package libllvm3.4:amd64.
        ==> default: Preparing to unpack .../libllvm3.4_1%3a3.4-1ubuntu3_amd64.deb ...
        ==> default: Unpacking libllvm3.4:amd64 (1:3.4-1ubuntu3) ...
        ==> default: Selecting previously unselected package libgl1-mesa-dri:amd64.
        ==> default: Preparing to unpack .../libgl1-mesa-dri_10.1.3-0ubuntu0.3_amd64.deb ...
        ==> default: Unpacking libgl1-mesa-dri:amd64 (10.1.3-0ubuntu0.3) ...
        ==> default: Selecting previously unselected package libglapi-mesa:amd64.
        ==> default: Preparing to unpack .../libglapi-mesa_10.1.3-0ubuntu0.3_amd64.deb ...
        ==> default: Unpacking libglapi-mesa:amd64 (10.1.3-0ubuntu0.3) ...
        ==> default: Selecting previously unselected package libx11-xcb1:amd64.
        ==> default: Preparing to unpack .../libx11-xcb1_2%3a1.6.2-1ubuntu2_amd64.deb ...
        ==> default: Unpacking libx11-xcb1:amd64 (2:1.6.2-1ubuntu2) ...
        ==> default: Selecting previously unselected package libxcb-dri2-0:amd64.
        ==> default: Preparing to unpack .../libxcb-dri2-0_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-dri2-0:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-dri3-0:amd64.
        ==> default: Preparing to unpack .../libxcb-dri3-0_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-dri3-0:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-glx0:amd64.
        ==> default: Preparing to unpack .../libxcb-glx0_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-glx0:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-present0:amd64.
        ==> default: Preparing to unpack .../libxcb-present0_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-present0:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-sync1:amd64.
        ==> default: Preparing to unpack .../libxcb-sync1_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-sync1:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxdamage1:amd64.
        ==> default: Preparing to unpack .../libxdamage1_1%3a1.1.4-1ubuntu1_amd64.deb ...
        ==> default: Unpacking libxdamage1:amd64 (1:1.1.4-1ubuntu1) ...
        ==> default: Selecting previously unselected package libxfixes3:amd64.
        ==> default: Preparing to unpack .../libxfixes3_1%3a5.0.1-1ubuntu1_amd64.deb ...
        ==> default: Unpacking libxfixes3:amd64 (1:5.0.1-1ubuntu1) ...
        ==> default: Selecting previously unselected package libxshmfence1:amd64.
        ==> default: Preparing to unpack .../libxshmfence1_1.1-2_amd64.deb ...
        ==> default: Unpacking libxshmfence1:amd64 (1.1-2) ...
        ==> default: Selecting previously unselected package libxxf86vm1:amd64.
        ==> default: Preparing to unpack .../libxxf86vm1_1%3a1.1.3-1_amd64.deb ...
        ==> default: Unpacking libxxf86vm1:amd64 (1:1.1.3-1) ...
        ==> default: Selecting previously unselected package libgl1-mesa-glx:amd64.
        ==> default: Preparing to unpack .../libgl1-mesa-glx_10.1.3-0ubuntu0.3_amd64.deb ...
        ==> default: Unpacking libgl1-mesa-glx:amd64 (10.1.3-0ubuntu0.3) ...
        ==> default: Selecting previously unselected package libice6:amd64.
        ==> default: Preparing to unpack .../libice6_2%3a1.0.8-2_amd64.deb ...
        ==> default: Unpacking libice6:amd64 (2:1.0.8-2) ...
        ==> default: Selecting previously unselected package libsm6:amd64.
        ==> default: Preparing to unpack .../libsm6_2%3a1.2.1-2_amd64.deb ...
        ==> default: Unpacking libsm6:amd64 (2:1.2.1-2) ...
        ==> default: Selecting previously unselected package libtcl8.6:amd64.
        ==> default: Preparing to unpack .../libtcl8.6_8.6.1-4ubuntu1_amd64.deb ...
        ==> default: Unpacking libtcl8.6:amd64 (8.6.1-4ubuntu1) ...
        ==> default: Selecting previously unselected package libtk8.6:amd64.
        ==> default: Preparing to unpack .../libtk8.6_8.6.1-3ubuntu2_amd64.deb ...
        ==> default: Unpacking libtk8.6:amd64 (8.6.1-3ubuntu2) ...
        ==> default: Selecting previously unselected package libxt6:amd64.
        ==> default: Preparing to unpack .../libxt6_1%3a1.1.4-1_amd64.deb ...
        ==> default: Unpacking libxt6:amd64 (1:1.1.4-1) ...
        ==> default: Selecting previously unselected package libxmu6:amd64.
        ==> default: Preparing to unpack .../libxmu6_2%3a1.1.1-1_amd64.deb ...
        ==> default: Unpacking libxmu6:amd64 (2:1.1.1-1) ...
        ==> default: Selecting previously unselected package libxpm4:amd64.
        ==> default: Preparing to unpack .../libxpm4_1%3a3.5.10-1_amd64.deb ...
        ==> default: Unpacking libxpm4:amd64 (1:3.5.10-1) ...
        ==> default: Selecting previously unselected package libxaw7:amd64.
        ==> default: Preparing to unpack .../libxaw7_2%3a1.0.12-1_amd64.deb ...
        ==> default: Unpacking libxaw7:amd64 (2:1.0.12-1) ...
        ==> default: Selecting previously unselected package libxcb-shape0:amd64.
        ==> default: Preparing to unpack .../libxcb-shape0_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-shape0:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcomposite1:amd64.
        ==> default: Preparing to unpack .../libxcomposite1_1%3a0.4.4-1_amd64.deb ...
        ==> default: Unpacking libxcomposite1:amd64 (1:0.4.4-1) ...
        ==> default: Selecting previously unselected package libxi6:amd64.
        ==> default: Preparing to unpack .../libxi6_2%3a1.7.1.901-1ubuntu1_amd64.deb ...
        ==> default: Unpacking libxi6:amd64 (2:1.7.1.901-1ubuntu1) ...
        ==> default: Selecting previously unselected package libxinerama1:amd64.
        ==> default: Preparing to unpack .../libxinerama1_2%3a1.1.3-1_amd64.deb ...
        ==> default: Unpacking libxinerama1:amd64 (2:1.1.3-1) ...
        ==> default: Selecting previously unselected package libxrandr2:amd64.
        ==> default: Preparing to unpack .../libxrandr2_2%3a1.4.2-1_amd64.deb ...
        ==> default: Unpacking libxrandr2:amd64 (2:1.4.2-1) ...
        ==> default: Selecting previously unselected package libxtst6:amd64.
        ==> default: Preparing to unpack .../libxtst6_2%3a1.2.2-1_amd64.deb ...
        ==> default: Unpacking libxtst6:amd64 (2:1.2.2-1) ...
        ==> default: Selecting previously unselected package libxv1:amd64.
        ==> default: Preparing to unpack .../libxv1_2%3a1.0.10-1_amd64.deb ...
        ==> default: Unpacking libxv1:amd64 (2:1.0.10-1) ...
        ==> default: Selecting previously unselected package libxxf86dga1:amd64.
        ==> default: Preparing to unpack .../libxxf86dga1_2%3a1.1.4-1_amd64.deb ...
        ==> default: Unpacking libxxf86dga1:amd64 (2:1.1.4-1) ...
        ==> default: Selecting previously unselected package libtxc-dxtn-s2tc0:amd64.
        ==> default: Preparing to unpack .../libtxc-dxtn-s2tc0_0~git20131104-1.1_amd64.deb ...
        ==> default: Unpacking libtxc-dxtn-s2tc0:amd64 (0~git20131104-1.1) ...
        ==> default: Selecting previously unselected package libutempter0.
        ==> default: Preparing to unpack .../libutempter0_1.1.5-4build1_amd64.deb ...
        ==> default: Unpacking libutempter0 (1.1.5-4build1) ...
        ==> default: Selecting previously unselected package mercurial-common.
        ==> default: Preparing to unpack .../mercurial-common_2.8.2-1ubuntu1_all.deb ...
        ==> default: Unpacking mercurial-common (2.8.2-1ubuntu1) ...
        ==> default: Selecting previously unselected package mercurial.
        ==> default: Preparing to unpack .../mercurial_2.8.2-1ubuntu1_amd64.deb ...
        ==> default: Unpacking mercurial (2.8.2-1ubuntu1) ...
        ==> default: Selecting previously unselected package tcl8.6.
        ==> default: Preparing to unpack .../tcl8.6_8.6.1-4ubuntu1_amd64.deb ...
        ==> default: Unpacking tcl8.6 (8.6.1-4ubuntu1) ...
        ==> default: Selecting previously unselected package tcl.
        ==> default: Preparing to unpack .../tcl_8.6.0+6ubuntu3_amd64.deb ...
        ==> default: Unpacking tcl (8.6.0+6ubuntu3) ...
        ==> default: Selecting previously unselected package tk8.6.
        ==> default: Preparing to unpack .../tk8.6_8.6.1-3ubuntu2_amd64.deb ...
        ==> default: Unpacking tk8.6 (8.6.1-3ubuntu2) ...
        ==> default: Selecting previously unselected package tk.
        ==> default: Preparing to unpack .../tk_8.6.0+6ubuntu3_amd64.deb ...
        ==> default: Unpacking tk (8.6.0+6ubuntu3) ...
        ==> default: Selecting previously unselected package x11-utils.
        ==> default: Preparing to unpack .../x11-utils_7.7+1_amd64.deb ...
        ==> default: Unpacking x11-utils (7.7+1) ...
        ==> default: Selecting previously unselected package xbitmaps.
        ==> default: Preparing to unpack .../xbitmaps_1.1.1-2_all.deb ...
        ==> default: Unpacking xbitmaps (1.1.1-2) ...
        ==> default: Selecting previously unselected package xterm.
        ==> default: Preparing to unpack .../xterm_297-1ubuntu1_amd64.deb ...
        ==> default: Unpacking xterm (297-1ubuntu1) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Processing triggers for mime-support (3.54ubuntu1) ...
        ==> default: Setting up libpciaccess0:amd64 (0.13.2-1) ...
        ==> default: Setting up libdrm-intel1:amd64 (2.4.56-1~ubuntu1) ...
        ==> default: Setting up libdrm-nouveau2:amd64 (2.4.56-1~ubuntu1) ...
        ==> default: Setting up libdrm-radeon1:amd64 (2.4.56-1~ubuntu1) ...
        ==> default: Setting up libfontenc1:amd64 (1:1.1.2-1) ...
        ==> default: Setting up libllvm3.4:amd64 (1:3.4-1ubuntu3) ...
        ==> default: Setting up libgl1-mesa-dri:amd64 (10.1.3-0ubuntu0.3) ...
        ==> default: Setting up libglapi-mesa:amd64 (10.1.3-0ubuntu0.3) ...
        ==> default: Setting up libx11-xcb1:amd64 (2:1.6.2-1ubuntu2) ...
        ==> default: Setting up libxcb-dri2-0:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-dri3-0:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-glx0:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-present0:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-sync1:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxdamage1:amd64 (1:1.1.4-1ubuntu1) ...
        ==> default: Setting up libxfixes3:amd64 (1:5.0.1-1ubuntu1) ...
        ==> default: Setting up libxshmfence1:amd64 (1.1-2) ...
        ==> default: Setting up libxxf86vm1:amd64 (1:1.1.3-1) ...
        ==> default: Setting up libgl1-mesa-glx:amd64 (10.1.3-0ubuntu0.3) ...
        ==> default: update-alternatives: using /usr/lib/x86_64-linux-gnu/mesa/ld.so.conf to provide /etc/ld.so.conf.d/x86_64-linux-        gnu_GL.conf (x86_64-linux-gnu_gl_conf) in auto mode
        ==> default: Setting up libice6:amd64 (2:1.0.8-2) ...
        ==> default: Setting up libsm6:amd64 (2:1.2.1-2) ...
        ==> default: Setting up libtcl8.6:amd64 (8.6.1-4ubuntu1) ...
        ==> default: Setting up libtk8.6:amd64 (8.6.1-3ubuntu2) ...
        ==> default: Setting up libxt6:amd64 (1:1.1.4-1) ...
        ==> default: Setting up libxmu6:amd64 (2:1.1.1-1) ...
        ==> default: Setting up libxpm4:amd64 (1:3.5.10-1) ...
        ==> default: Setting up libxaw7:amd64 (2:1.0.12-1) ...
        ==> default: Setting up libxcb-shape0:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcomposite1:amd64 (1:0.4.4-1) ...
        ==> default: Setting up libxi6:amd64 (2:1.7.1.901-1ubuntu1) ...
        ==> default: Setting up libxinerama1:amd64 (2:1.1.3-1) ...
        ==> default: Setting up libxrandr2:amd64 (2:1.4.2-1) ...
        ==> default: Setting up libxtst6:amd64 (2:1.2.2-1) ...
        ==> default: Setting up libxv1:amd64 (2:1.0.10-1) ...
        ==> default: Setting up libxxf86dga1:amd64 (2:1.1.4-1) ...
        ==> default: Setting up libtxc-dxtn-s2tc0:amd64 (0~git20131104-1.1) ...
        ==> default: update-alternatives: using /usr/lib/x86_64-linux-gnu/libtxc_dxtn_s2tc.so.0 to provide /usr/lib/x86_64-linux-        gnu/libtxc_dxtn.so (libtxc-dxtn-x86_64-linux-gnu) in auto mode
        ==> default: Setting up libutempter0 (1.1.5-4build1) ...
        ==> default: Creating utempter group...
        ==> default: Setting up mercurial-common (2.8.2-1ubuntu1) ...
        ==> default: Setting up mercurial (2.8.2-1ubuntu1) ...
        ==> default: 
        ==> default: Creating config file /etc/mercurial/hgrc.d/hgext.rc with new version
        ==> default: Setting up tcl8.6 (8.6.1-4ubuntu1) ...
        ==> default: Setting up tcl (8.6.0+6ubuntu3) ...
        ==> default: Setting up tk8.6 (8.6.1-3ubuntu2) ...
        ==> default: Setting up tk (8.6.0+6ubuntu3) ...
        ==> default: Setting up x11-utils (7.7+1) ...
        ==> default: Setting up xbitmaps (1.1.1-2) ...
        ==> default: Setting up xterm (297-1ubuntu1) ...
        ==> default: update-alternatives: using /usr/bin/xterm to provide /usr/bin/x-terminal-emulator (x-terminal-emulator) in auto         mode
        ==> default: update-alternatives: using /usr/bin/lxterm to provide /usr/bin/x-terminal-emulator (x-terminal-emulator) in auto         mode
        ==> default: Processing triggers for libc-bin (2.19-0ubuntu6) ...
        ==> default: hg: Mercurial Distributed SCM (version 2.8.2)
        ==> default: Installing java...
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following extra packages will be installed:
        ==> default:   ca-certificates-java java-common libasyncns0 libavahi-client3
        ==> default:   libavahi-common-data libavahi-common3 libcups2 libflac8 libjpeg-turbo8
        ==> default:   libjpeg8 liblcms2-2 libnspr4 libnss3 libnss3-nssdb libogg0 libpcsclite1
        ==> default:   libpulse0 libsndfile1 libvorbis0a libvorbisenc2 tzdata tzdata-java
        ==> default: Suggested packages:
        ==> default:   default-jre equivs cups-common liblcms2-utils pcscd pulseaudio
        ==> default:   icedtea-7-jre-jamvm libnss-mdns sun-java6-fonts fonts-dejavu-extra
        ==> default:   fonts-ipafont-gothic fonts-ipafont-mincho ttf-wqy-microhei ttf-wqy-zenhei
        ==> default:   ttf-indic-fonts-core ttf-telugu-fonts ttf-oriya-fonts ttf-kannada-fonts
        ==> default:   ttf-bengali-fonts
        ==> default: The following NEW packages will be installed:
        ==> default:   ca-certificates-java java-common libasyncns0 libavahi-client3
        ==> default:   libavahi-common-data libavahi-common3 libcups2 libflac8 libjpeg-turbo8
        ==> default:   libjpeg8 liblcms2-2 libnspr4 libnss3 libnss3-nssdb libogg0 libpcsclite1
        ==> default:   libpulse0 libsndfile1 libvorbis0a libvorbisenc2 openjdk-7-jre-headless
        ==> default:   tzdata-java
        ==> default: The following packages will be upgraded:
        ==> default:   tzdata
        ==> default: 1 upgraded, 22 newly installed, 0 to remove and 125 not upgraded.
        ==> default: Need to get 42.3 MB of archives.
        ==> default: After this operation, 69.5 MB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/main libasyncns0 amd64 0.8-4ubuntu2 [11.9 kB]
        ==> default: Get:2 http://us.archive.ubuntu.com/ubuntu/ trusty/main libavahi-common-data amd64 0.6.31-4ubuntu1 [21.2 kB]
        ==> default: Get:3 http://us.archive.ubuntu.com/ubuntu/ trusty/main libavahi-common3 amd64 0.6.31-4ubuntu1 [21.7 kB]
        ==> default: Get:4 http://us.archive.ubuntu.com/ubuntu/ trusty/main libavahi-client3 amd64 0.6.31-4ubuntu1 [25.1 kB]
        ==> default: Get:5 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libcups2 amd64 1.7.2-0ubuntu1.2 [179 kB]
        ==> default: Get:6 http://us.archive.ubuntu.com/ubuntu/ trusty/main libogg0 amd64 1.3.1-1ubuntu1 [17.0 kB]
        ==> default: Get:7 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libflac8 amd64 1.3.0-2ubuntu0.14.04.1 [80.2 kB]
        ==> default: Get:8 http://us.archive.ubuntu.com/ubuntu/ trusty/main libjpeg-turbo8 amd64 1.3.0-0ubuntu2 [104 kB]
        ==> default: Get:9 http://us.archive.ubuntu.com/ubuntu/ trusty/main liblcms2-2 amd64 2.5-0ubuntu4 [132 kB]
        ==> default: Get:10 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libnspr4 amd64 2:4.10.7-0ubuntu0.14.04.1 [111 kB]
        ==> default: Get:11 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libnss3-nssdb all 2:3.17.1-0ubuntu0.14.04.2 [10.        6 kB]
        ==> default: Get:12 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libnss3 amd64 2:3.17.1-0ubuntu0.14.04.2 [1,094 kB        ]
        ==> default: Get:13 http://us.archive.ubuntu.com/ubuntu/ trusty/main libpcsclite1 amd64 1.8.10-1ubuntu1 [20.9 kB]
        ==> default: Get:14 http://us.archive.ubuntu.com/ubuntu/ trusty/main libvorbis0a amd64 1.3.2-1.3ubuntu1 [87.2 kB]
        ==> default: Get:15 http://us.archive.ubuntu.com/ubuntu/ trusty/main libvorbisenc2 amd64 1.3.2-1.3ubuntu1 [84.5 kB]
        ==> default: Get:16 http://us.archive.ubuntu.com/ubuntu/ trusty/main libsndfile1 amd64 1.0.25-7ubuntu2 [136 kB]
        ==> default: Get:17 http://us.archive.ubuntu.com/ubuntu/ trusty/main libpulse0 amd64 1:4.0-0ubuntu11 [225 kB]
        ==> default: Get:18 http://us.archive.ubuntu.com/ubuntu/ trusty/main ca-certificates-java all 20130815ubuntu1 [13.4 kB]
        ==> default: Get:19 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main tzdata all 2014i-0ubuntu0.14.04 [173 kB]
        ==> default: Get:20 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main tzdata-java all 2014i-0ubuntu0.14.04 [69.9 kB]
        ==> default: Get:21 http://us.archive.ubuntu.com/ubuntu/ trusty/main java-common all 0.51 [130 kB]
        ==> default: Get:22 http://us.archive.ubuntu.com/ubuntu/ trusty/main libjpeg8 amd64 8c-2ubuntu8 [2,194 B]
        ==> default: Get:23 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main openjdk-7-jre-headless amd64 7u71-2.5.3-0ubuntu0.        14.04.1 [39.5 MB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 42.3 MB in 21s (1,999 kB/s)
        ==> default: Selecting previously unselected package libasyncns0:amd64.
        ==> default: (Reading database ... 56382 files and directories currently installed.)
        ==> default: Preparing to unpack .../libasyncns0_0.8-4ubuntu2_amd64.deb ...
        ==> default: Unpacking libasyncns0:amd64 (0.8-4ubuntu2) ...
        ==> default: Selecting previously unselected package libavahi-common-data:amd64.
        ==> default: Preparing to unpack .../libavahi-common-data_0.6.31-4ubuntu1_amd64.deb ...
        ==> default: Unpacking libavahi-common-data:amd64 (0.6.31-4ubuntu1) ...
        ==> default: Selecting previously unselected package libavahi-common3:amd64.
        ==> default: Preparing to unpack .../libavahi-common3_0.6.31-4ubuntu1_amd64.deb ...
        ==> default: Unpacking libavahi-common3:amd64 (0.6.31-4ubuntu1) ...
        ==> default: Selecting previously unselected package libavahi-client3:amd64.
        ==> default: Preparing to unpack .../libavahi-client3_0.6.31-4ubuntu1_amd64.deb ...
        ==> default: Unpacking libavahi-client3:amd64 (0.6.31-4ubuntu1) ...
        ==> default: Selecting previously unselected package libcups2:amd64.
        ==> default: Preparing to unpack .../libcups2_1.7.2-0ubuntu1.2_amd64.deb ...
        ==> default: Unpacking libcups2:amd64 (1.7.2-0ubuntu1.2) ...
        ==> default: Selecting previously unselected package libogg0:amd64.
        ==> default: Preparing to unpack .../libogg0_1.3.1-1ubuntu1_amd64.deb ...
        ==> default: Unpacking libogg0:amd64 (1.3.1-1ubuntu1) ...
        ==> default: Selecting previously unselected package libflac8:amd64.
        ==> default: Preparing to unpack .../libflac8_1.3.0-2ubuntu0.14.04.1_amd64.deb ...
        ==> default: Unpacking libflac8:amd64 (1.3.0-2ubuntu0.14.04.1) ...
        ==> default: Selecting previously unselected package libjpeg-turbo8:amd64.
        ==> default: Preparing to unpack .../libjpeg-turbo8_1.3.0-0ubuntu2_amd64.deb ...
        ==> default: Unpacking libjpeg-turbo8:amd64 (1.3.0-0ubuntu2) ...
        ==> default: Selecting previously unselected package liblcms2-2:amd64.
        ==> default: Preparing to unpack .../liblcms2-2_2.5-0ubuntu4_amd64.deb ...
        ==> default: Unpacking liblcms2-2:amd64 (2.5-0ubuntu4) ...
        ==> default: Selecting previously unselected package libnspr4:amd64.
        ==> default: Preparing to unpack .../libnspr4_2%3a4.10.7-0ubuntu0.14.04.1_amd64.deb ...
        ==> default: Unpacking libnspr4:amd64 (2:4.10.7-0ubuntu0.14.04.1) ...
        ==> default: Selecting previously unselected package libnss3-nssdb.
        ==> default: Preparing to unpack .../libnss3-nssdb_2%3a3.17.1-0ubuntu0.14.04.2_all.deb ...
        ==> default: Unpacking libnss3-nssdb (2:3.17.1-0ubuntu0.14.04.2) ...
        ==> default: Selecting previously unselected package libnss3:amd64.
        ==> default: Preparing to unpack .../libnss3_2%3a3.17.1-0ubuntu0.14.04.2_amd64.deb ...
        ==> default: Unpacking libnss3:amd64 (2:3.17.1-0ubuntu0.14.04.2) ...
        ==> default: Selecting previously unselected package libpcsclite1:amd64.
        ==> default: Preparing to unpack .../libpcsclite1_1.8.10-1ubuntu1_amd64.deb ...
        ==> default: Unpacking libpcsclite1:amd64 (1.8.10-1ubuntu1) ...
        ==> default: Selecting previously unselected package libvorbis0a:amd64.
        ==> default: Preparing to unpack .../libvorbis0a_1.3.2-1.3ubuntu1_amd64.deb ...
        ==> default: Unpacking libvorbis0a:amd64 (1.3.2-1.3ubuntu1) ...
        ==> default: Selecting previously unselected package libvorbisenc2:amd64.
        ==> default: Preparing to unpack .../libvorbisenc2_1.3.2-1.3ubuntu1_amd64.deb ...
        ==> default: Unpacking libvorbisenc2:amd64 (1.3.2-1.3ubuntu1) ...
        ==> default: Selecting previously unselected package libsndfile1:amd64.
        ==> default: Preparing to unpack .../libsndfile1_1.0.25-7ubuntu2_amd64.deb ...
        ==> default: Unpacking libsndfile1:amd64 (1.0.25-7ubuntu2) ...
        ==> default: Selecting previously unselected package libpulse0:amd64.
        ==> default: Preparing to unpack .../libpulse0_1%3a4.0-0ubuntu11_amd64.deb ...
        ==> default: Unpacking libpulse0:amd64 (1:4.0-0ubuntu11) ...
        ==> default: Selecting previously unselected package ca-certificates-java.
        ==> default: Preparing to unpack .../ca-certificates-java_20130815ubuntu1_all.deb ...
        ==> default: Unpacking ca-certificates-java (20130815ubuntu1) ...
        ==> default: Preparing to unpack .../tzdata_2014i-0ubuntu0.14.04_all.deb ...
        ==> default: Unpacking tzdata (2014i-0ubuntu0.14.04) over (2014b-1) ...
        ==> default: Processing triggers for ca-certificates (20130906ubuntu2) ...
        ==> default: Updating certificates in /etc/ssl/certs... 
        ==> default: 0 added, 0 removed; done.
        ==> default: Running hooks in /etc/ca-certificates/update.d....
        ==> default: done.
        ==> default: Setting up tzdata (2014i-0ubuntu0.14.04) ...
        ==> default: 
        ==> default: Current default time zone: 'Etc/UTC'
        ==> default: Local time is now:      Tue Jan 27 08:54:25 UTC 2015.
        ==> default: Universal Time is now:  Tue Jan 27 08:54:25 UTC 2015.
        ==> default: Run 'dpkg-reconfigure tzdata' if you wish to change it.
        ==> default: Selecting previously unselected package tzdata-java.
        ==> default: (Reading database ... 56525 files and directories currently installed.)
        ==> default: Preparing to unpack .../tzdata-java_2014i-0ubuntu0.14.04_all.deb ...
        ==> default: Unpacking tzdata-java (2014i-0ubuntu0.14.04) ...
        ==> default: Selecting previously unselected package java-common.
        ==> default: Preparing to unpack .../java-common_0.51_all.deb ...
        ==> default: Unpacking java-common (0.51) ...
        ==> default: Selecting previously unselected package libjpeg8:amd64.
        ==> default: Preparing to unpack .../libjpeg8_8c-2ubuntu8_amd64.deb ...
        ==> default: Unpacking libjpeg8:amd64 (8c-2ubuntu8) ...
        ==> default: Selecting previously unselected package openjdk-7-jre-headless:amd64.
        ==> default: Preparing to unpack .../openjdk-7-jre-headless_7u71-2.5.3-0ubuntu0.14.04.1_amd64.deb ...
        ==> default: Unpacking openjdk-7-jre-headless:amd64 (7u71-2.5.3-0ubuntu0.14.04.1) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Setting up libasyncns0:amd64 (0.8-4ubuntu2) ...
        ==> default: Setting up libavahi-common-data:amd64 (0.6.31-4ubuntu1) ...
        ==> default: Setting up libavahi-common3:amd64 (0.6.31-4ubuntu1) ...
        ==> default: Setting up libavahi-client3:amd64 (0.6.31-4ubuntu1) ...
        ==> default: Setting up libcups2:amd64 (1.7.2-0ubuntu1.2) ...
        ==> default: Setting up libogg0:amd64 (1.3.1-1ubuntu1) ...
        ==> default: Setting up libflac8:amd64 (1.3.0-2ubuntu0.14.04.1) ...
        ==> default: Setting up libjpeg-turbo8:amd64 (1.3.0-0ubuntu2) ...
        ==> default: Setting up liblcms2-2:amd64 (2.5-0ubuntu4) ...
        ==> default: Setting up libnspr4:amd64 (2:4.10.7-0ubuntu0.14.04.1) ...
        ==> default: Setting up libpcsclite1:amd64 (1.8.10-1ubuntu1) ...
        ==> default: Setting up libvorbis0a:amd64 (1.3.2-1.3ubuntu1) ...
        ==> default: Setting up libvorbisenc2:amd64 (1.3.2-1.3ubuntu1) ...
        ==> default: Setting up libsndfile1:amd64 (1.0.25-7ubuntu2) ...
        ==> default: Setting up libpulse0:amd64 (1:4.0-0ubuntu11) ...
        ==> default: Setting up tzdata-java (2014i-0ubuntu0.14.04) ...
        ==> default: Setting up java-common (0.51) ...
        ==> default: Setting up libjpeg8:amd64 (8c-2ubuntu8) ...
        ==> default: Setting up libnss3-nssdb (2:3.17.1-0ubuntu0.14.04.2) ...
        ==> default: Setting up libnss3:amd64 (2:3.17.1-0ubuntu0.14.04.2) ...
        ==> default: Setting up ca-certificates-java (20130815ubuntu1) ...
        ==> default: Adding debian:Hellenic_Academic_and_Research_Institutions_RootCA_2011.pem
        ==> default: Adding debian:COMODO_Certification_Authority.pem
        ==> default: Adding debian:Baltimore_CyberTrust_Root.pem
        ==> default: Adding debian:UTN_DATACorp_SGC_Root_CA.pem
        ==> default: Adding debian:Thawte_Server_CA.pem
        ==> default: Adding debian:PSCProcert.pem
        ==> default: Adding debian:SecureSign_RootCA11.pem
        ==> default: Adding debian:COMODO_ECC_Certification_Authority.pem
        ==> default: Adding debian:NetLock_Express_=Class_C=_Root.pem
        ==> default: Adding debian:Microsec_e-Szigno_Root_CA_2009.pem
        ==> default: Adding debian:Equifax_Secure_eBusiness_CA_1.pem
        ==> default: Adding debian:CA_Disig_Root_R1.pem
        ==> default: Adding debian:CNNIC_ROOT.pem
        ==> default: Adding debian:Root_CA_Generalitat_Valenciana.pem
        ==> default: Adding debian:NetLock_Business_=Class_B=_Root.pem
        ==> default: Adding debian:Staat_der_Nederlanden_Root_CA_-_G2.pem
        ==> default: Adding debian:Verisign_Class_3_Public_Primary_Certification_Authority_-_G2.pem
        ==> default: Adding debian:Certum_Trusted_Network_CA.pem
        ==> default: Adding debian:UTN_USERFirst_Hardware_Root_CA.pem
        ==> default: Adding debian:Trustis_FPS_Root_CA.pem
        ==> default: Adding debian:TWCA_Root_Certification_Authority.pem
        ==> default: Adding debian:EBG_Elektronik_Sertifika_Hizmet_Sağlayıcısı.pem
        ==> default: Adding debian:China_Internet_Network_Information_Center_EV_Certificates_Root.pem
        ==> default: Adding debian:Deutsche_Telekom_Root_CA_2.pem
        ==> default: Adding debian:D-TRUST_Root_Class_3_CA_2_EV_2009.pem
        ==> default: Adding debian:thawte_Primary_Root_CA.pem
        ==> default: Adding debian:GeoTrust_Universal_CA_2.pem
        ==> default: Adding debian:AddTrust_Low-Value_Services_Root.pem
        ==> default: Adding debian:Verisign_Class_2_Public_Primary_Certification_Authority_-_G3.pem
        ==> default: Adding debian:VeriSign_Universal_Root_Certification_Authority.pem
        ==> default: Adding debian:Verisign_Class_1_Public_Primary_Certification_Authority.pem
        ==> default: Adding debian:XRamp_Global_CA_Root.pem
        ==> default: Adding debian:Autoridad_de_Certificacion_Firmaprofesional_CIF_A62634068.pem
        ==> default: Adding debian:GeoTrust_Primary_Certification_Authority_-_G3.pem
        ==> default: Adding debian:AffirmTrust_Networking.pem
        ==> default: Adding debian:Buypass_Class_3_Root_CA.pem
        ==> default: Adding debian:America_Online_Root_Certification_Authority_1.pem
        ==> default: Adding debian:TC_TrustCenter_Class_2_CA_II.pem
        ==> default: Adding debian:Microsec_e-Szigno_Root_CA.pem
        ==> default: Adding debian:thawte_Primary_Root_CA_-_G2.pem
        ==> default: Adding debian:IGC_A.pem
        ==> default: Adding debian:Certigna.pem
        ==> default: Adding debian:StartCom_Certification_Authority_2.pem
        ==> default: Adding debian:Equifax_Secure_CA.pem
        ==> default: Adding debian:AffirmTrust_Premium.pem
        ==> default: Adding debian:Security_Communication_EV_RootCA1.pem
        ==> default: Adding debian:NetLock_Arany_=Class_Gold=_Főtanúsítvány.pem
        ==> default: Adding debian:RSA_Root_Certificate_1.pem
        ==> default: Adding debian:ValiCert_Class_1_VA.pem
        ==> default: Adding debian:OISTE_WISeKey_Global_Root_GA_CA.pem
        ==> default: Adding debian:VeriSign_Class_3_Public_Primary_Certification_Authority_-_G4.pem
        ==> default: Adding debian:GTE_CyberTrust_Global_Root.pem
        ==> default: Adding debian:Firmaprofesional_Root_CA.pem
        ==> default: Adding debian:Camerfirma_Global_Chambersign_Root.pem
        ==> default: Adding debian:QuoVadis_Root_CA_2.pem
        ==> default: Adding debian:DigiCert_High_Assurance_EV_Root_CA.pem
        ==> default: Adding debian:Verisign_Class_1_Public_Primary_Certification_Authority_-_G2.pem
        ==> default: Adding debian:Swisscom_Root_EV_CA_2.pem
        ==> default: Adding debian:EC-ACC.pem
        ==> default: Adding debian:EE_Certification_Centre_Root_CA.pem
        ==> default: Adding debian:ePKI_Root_Certification_Authority.pem
        ==> default: Adding debian:AddTrust_Qualified_Certificates_Root.pem
        ==> default: Adding debian:ACEDICOM_Root.pem
        ==> default: Adding debian:Visa_eCommerce_Root.pem
        ==> default: Adding debian:Entrust.net_Premium_2048_Secure_Server_CA.pem
        ==> default: Adding debian:ValiCert_Class_2_VA.pem
        ==> default: Adding debian:Juur-SK.pem
        ==> default: Adding debian:Cybertrust_Global_Root.pem
        ==> default: Adding debian:D-TRUST_Root_Class_3_CA_2_2009.pem
        ==> default: Adding debian:TC_TrustCenter_Universal_CA_I.pem
        ==> default: Adding debian:NetLock_Qualified_=Class_QA=_Root.pem
        ==> default: Adding debian:Staat_der_Nederlanden_Root_CA.pem
        ==> default: Adding debian:Certplus_Class_2_Primary_CA.pem
        ==> default: Adding debian:TÜBİTAK_UEKAE_Kök_Sertifika_Hizmet_Sağlayıcısı_-_Sürüm_3.pem
        ==> default: Adding debian:Wells_Fargo_Root_CA.pem
        ==> default: Adding debian:TURKTRUST_Certificate_Services_Provider_Root_2.pem
        ==> default: Adding debian:ComSign_CA.pem
        ==> default: Adding debian:CA_Disig.pem
        ==> default: Adding debian:Secure_Global_CA.pem
        ==> default: Adding debian:TURKTRUST_Certificate_Services_Provider_Root_1.pem
        ==> default: Adding debian:SwissSign_Gold_CA_-_G2.pem
        ==> default: Adding debian:GeoTrust_Global_CA.pem
        ==> default: Adding debian:Equifax_Secure_Global_eBusiness_CA.pem
        ==> default: Adding debian:AffirmTrust_Commercial.pem
        ==> default: Adding debian:S-TRUST_Authentication_and_Encryption_Root_CA_2005_PN.pem
        ==> default: Adding debian:Digital_Signature_Trust_Co._Global_CA_3.pem
        ==> default: Adding debian:Swisscom_Root_CA_2.pem
        ==> default: Adding debian:ApplicationCA_-_Japanese_Government.pem
        ==> default: Adding debian:GlobalSign_Root_CA_-_R3.pem
        ==> default: Adding debian:Certum_Root_CA.pem
        ==> default: Adding debian:Security_Communication_Root_CA.pem
        ==> default: Adding debian:Starfield_Class_2_CA.pem
        ==> default: Adding debian:Sonera_Class_2_Root_CA.pem
        ==> default: Adding debian:AddTrust_External_Root.pem
        ==> default: Adding debian:VeriSign_Class_3_Public_Primary_Certification_Authority_-_G5.pem
        ==> default: Adding debian:Actalis_Authentication_Root_CA.pem
        ==> default: Adding debian:Buypass_Class_2_Root_CA.pem
        ==> default: Adding debian:Starfield_Root_Certificate_Authority_-_G2.pem
        ==> default: Adding debian:AffirmTrust_Premium_ECC.pem
        ==> default: Adding debian:Verisign_Class_3_Public_Primary_Certification_Authority_-_G3.pem
        ==> default: Adding debian:QuoVadis_Root_CA.pem
        ==> default: Adding debian:WellsSecure_Public_Root_Certificate_Authority.pem
        ==> default: Adding debian:Sonera_Class_1_Root_CA.pem
        ==> default: Adding debian:DigiCert_Assured_ID_Root_CA.pem
        ==> default: Adding debian:GeoTrust_Global_CA_2.pem
        ==> default: Adding debian:Network_Solutions_Certificate_Authority.pem
        ==> default: Adding debian:GeoTrust_Universal_CA.pem
        ==> default: Adding debian:DST_Root_CA_X3.pem
        ==> default: Adding debian:thawte_Primary_Root_CA_-_G3.pem
        ==> default: Adding debian:SecureTrust_CA.pem
        ==> default: Adding debian:Entrust_Root_Certification_Authority.pem
        ==> default: Adding debian:Verisign_Class_1_Public_Primary_Certification_Authority_-_G3.pem
        ==> default: Adding debian:TDC_Internet_Root_CA.pem
        ==> default: Adding debian:ComSign_Secured_CA.pem
        ==> default: Adding debian:Comodo_Secure_Services_root.pem
        ==> default: Adding debian:Comodo_AAA_Services_root.pem
        ==> default: Adding debian:Camerfirma_Chambers_of_Commerce_Root.pem
        ==> default: Adding debian:SwissSign_Silver_CA_-_G2.pem
        ==> default: Adding debian:GlobalSign_Root_CA.pem
        ==> default: Adding debian:TC_TrustCenter_Class_3_CA_II.pem
        ==> default: Adding debian:Go_Daddy_Root_Certificate_Authority_-_G2.pem
        ==> default: Adding debian:CA_Disig_Root_R2.pem
        ==> default: Adding debian:Hongkong_Post_Root_CA_1.pem
        ==> default: Adding debian:StartCom_Certification_Authority_G2.pem
        ==> default: Adding debian:UTN_USERFirst_Email_Root_CA.pem
        ==> default: Adding debian:GeoTrust_Primary_Certification_Authority.pem
        ==> default: Adding debian:Certinomis_-_Autorité_Racine.pem
        ==> default: Adding debian:Verisign_Class_3_Public_Primary_Certification_Authority.pem
        ==> default: Adding debian:Verisign_Class_3_Public_Primary_Certification_Authority_2.pem
        ==> default: Adding debian:Comodo_Trusted_Services_root.pem
        ==> default: Adding debian:DST_ACES_CA_X6.pem
        ==> default: Adding debian:Starfield_Services_Root_Certificate_Authority_-_G2.pem
        ==> default: Adding debian:Verisign_Class_4_Public_Primary_Certification_Authority_-_G3.pem
        ==> default: Adding debian:Izenpe.com.pem
        ==> default: Adding debian:Entrust.net_Secure_Server_CA.pem
        ==> default: Adding debian:GeoTrust_Primary_Certification_Authority_-_G2.pem
        ==> default: Adding debian:SwissSign_Platinum_CA_-_G2.pem
        ==> default: Adding debian:AddTrust_Public_Services_Root.pem
        ==> default: Adding debian:Taiwan_GRCA.pem
        ==> default: Adding debian:A-Trust-nQual-03.pem
        ==> default: Adding debian:Buypass_Class_3_CA_1.pem
        ==> default: Adding debian:StartCom_Certification_Authority.pem
        ==> default: Adding debian:RSA_Security_2048_v3.pem
        ==> default: Adding debian:Go_Daddy_Class_2_CA.pem
        ==> default: Adding debian:Global_Chambersign_Root_-_2008.pem
        ==> default: Adding debian:NetLock_Notary_=Class_A=_Root.pem
        ==> default: Adding debian:Chambers_of_Commerce_Root_-_2008.pem
        ==> default: Adding debian:spi-cacert-2008.pem
        ==> default: Adding debian:QuoVadis_Root_CA_3.pem
        ==> default: Adding debian:AC_Raíz_Certicámara_S.A..pem
        ==> default: Adding debian:GlobalSign_Root_CA_-_R2.pem
        ==> default: Adding debian:DigiCert_Global_Root_CA.pem
        ==> default: Adding debian:Thawte_Premium_Server_CA.pem
        ==> default: Adding debian:E-Guven_Kok_Elektronik_Sertifika_Hizmet_Saglayicisi.pem
        ==> default: Adding debian:Verisign_Class_2_Public_Primary_Certification_Authority_-_G2.pem
        ==> default: Adding debian:TURKTRUST_Certificate_Services_Provider_Root_2007.pem
        ==> default: Adding debian:certSIGN_ROOT_CA.pem
        ==> default: Adding debian:Digital_Signature_Trust_Co._Global_CA_1.pem
        ==> default: Adding debian:America_Online_Root_Certification_Authority_2.pem
        ==> default: Adding debian:Security_Communication_RootCA2.pem
        ==> default: Adding debian:TDC_OCES_Root_CA.pem
        ==> default: Adding debian:T-TeleSec_GlobalRoot_Class_3.pem
        ==> default: Adding debian:Swisscom_Root_CA_1.pem
        ==> default: Adding debian:Buypass_Class_2_CA_1.pem
        ==> default: done.
        ==> default: Setting up openjdk-7-jre-headless:amd64 (7u71-2.5.3-0ubuntu0.14.04.1) ...
        ==> default: update-alternatives: using /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java to provide /usr/bin/java (java) in         auto mode
        ==> default: update-alternatives: using /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/keytool to provide /usr/bin/keytool (keytool        ) in auto mode
        ==> default: update-alternatives: using /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/pack200 to provide /usr/bin/pack200 (pack200        ) in auto mode
        ==> default: update-alternatives: using /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/rmid to provide /usr/bin/rmid (rmid) in         auto mode
        ==> default: update-alternatives: using /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/rmiregistry to provide /usr/bin/rmiregistry         (rmiregistry) in auto mode
        ==> default: update-alternatives: using /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/unpack200 to provide /usr/bin/unpack200 (        unpack200) in auto mode
        ==> default: update-alternatives: using /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/orbd to provide /usr/bin/orbd (orbd) in         auto mode
        ==> default: update-alternatives: using /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/servertool to provide /usr/bin/servertool (        servertool) in auto mode
        ==> default: update-alternatives: using /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/tnameserv to provide /usr/bin/tnameserv (        tnameserv) in auto mode
        ==> default: update-alternatives: using /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/jexec to provide /usr/bin/jexec (jexec) in         auto mode
        ==> default: Processing triggers for libc-bin (2.19-0ubuntu6) ...
        ==> default: Processing triggers for ca-certificates (20130906ubuntu2) ...
        ==> default: Updating certificates in /etc/ssl/certs... 
        ==> default: 0 added, 0 removed; done.
        ==> default: Running hooks in /etc/ca-certificates/update.d....
        ==> default: done.
        ==> default: done.
        ==> default: java: 1.7.0_65
        ==> default: Installing NodeJs & NPM ...
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following extra packages will be installed:
        ==> default:   gyp javascript-common libc-ares-dev libc-ares2 libjs-node-uuid
        ==> default:   libv8-3.14-dev libv8-3.14.5 node-abbrev node-ansi node-archy node-async
        ==> default:   node-block-stream node-combined-stream node-cookie-jar node-delayed-stream
        ==> default:   node-forever-agent node-form-data node-fstream node-fstream-ignore
        ==> default:   node-github-url-from-git node-glob node-graceful-fs node-gyp node-inherits
        ==> default:   node-ini node-json-stringify-safe node-lockfile node-lru-cache node-mime
        ==> default:   node-minimatch node-mkdirp node-mute-stream node-node-uuid node-nopt
        ==> default:   node-normalize-package-data node-npmlog node-once node-osenv node-qs
        ==> default:   node-read node-read-package-json node-request node-retry node-rimraf
        ==> default:   node-semver node-sha node-sigmund node-slide node-tar node-tunnel-agent
        ==> default:   node-which nodejs-dev python-pkg-resources
        ==> default: Suggested packages:
        ==> default:   apache2 lighttpd httpd node-hawk node-aws-sign node-oauth-sign
        ==> default:   node-http-signature python-distribute python-distribute-doc
        ==> default: The following NEW packages will be installed:
        ==> default:   gyp javascript-common libc-ares-dev libc-ares2 libjs-node-uuid
        ==> default:   libv8-3.14-dev libv8-3.14.5 node-abbrev node-ansi node-archy node-async
        ==> default:   node-block-stream node-combined-stream node-cookie-jar node-delayed-stream
        ==> default:   node-forever-agent node-form-data node-fstream node-fstream-ignore
        ==> default:   node-github-url-from-git node-glob node-graceful-fs node-gyp node-inherits
        ==> default:   node-ini node-json-stringify-safe node-lockfile node-lru-cache node-mime
        ==> default:   node-minimatch node-mkdirp node-mute-stream node-node-uuid node-nopt
        ==> default:   node-normalize-package-data node-npmlog node-once node-osenv node-qs
        ==> default:   node-read node-read-package-json node-request node-retry node-rimraf
        ==> default:   node-semver node-sha node-sigmund node-slide node-tar node-tunnel-agent
        ==> default:   node-which nodejs nodejs-dev npm python-pkg-resources
        ==> default: 0 upgraded, 55 newly installed, 0 to remove and 125 not upgraded.
        ==> default: Need to get 3,302 kB of archives.
        ==> default: After this operation, 14.3 MB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/main libc-ares2 amd64 1.10.0-2 [38.5 kB]
        ==> default: Get:2 http://us.archive.ubuntu.com/ubuntu/ trusty/main python-pkg-resources all 3.3-1ubuntu1 [61.9 kB]
        ==> default: Get:3 http://us.archive.ubuntu.com/ubuntu/ trusty/universe gyp all 0.1~svn1729-3ubuntu1 [201 kB]
        ==> default: Get:4 http://us.archive.ubuntu.com/ubuntu/ trusty/main javascript-common all 11 [6,066 B]
        ==> default: Get:5 http://us.archive.ubuntu.com/ubuntu/ trusty/universe libjs-node-uuid all 1.4.0-1 [11.1 kB]
        ==> default: Get:6 http://us.archive.ubuntu.com/ubuntu/ trusty/universe libv8-3.14.5 amd64 3.14.5.8-5ubuntu2 [1,189 kB]
        ==> default: Get:7 http://us.archive.ubuntu.com/ubuntu/ trusty/universe libv8-3.14-dev amd64 3.14.5.8-5ubuntu2 [57.6 kB]
        ==> default: Get:8 http://us.archive.ubuntu.com/ubuntu/ trusty/universe nodejs amd64 0.10.25~dfsg2-2ubuntu1 [684 kB]
        ==> default: Get:9 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-async all 0.2.5-1 [17.7 kB]
        ==> default: Get:10 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-node-uuid all 1.4.0-1 [2,530 B]
        ==> default: Get:11 http://us.archive.ubuntu.com/ubuntu/ trusty/main libc-ares-dev amd64 1.10.0-2 [109 kB]
        ==> default: Get:12 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-abbrev all 1.0.4-2 [3,814 B]
        ==> default: Get:13 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-ansi all 0.2.1-1 [8,692 B]
        ==> default: Get:14 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-archy all 0.0.2-1 [3,660 B]
        ==> default: Get:15 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-inherits all 2.0.0-1 [3,090 B]
        ==> default: Get:16 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-block-stream all 0.0.7-1 [4,832 B]
        ==> default: Get:17 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-delayed-stream all 0.0.5-1 [4,750 B]
        ==> default: Get:18 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-combined-stream all 0.0.4-1 [4,686 B]
        ==> default: Get:19 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-cookie-jar all 0.3.1-1 [3,746 B]
        ==> default: Get:20 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-forever-agent all 0.5.1-1 [3,194 B]
        ==> default: Get:21 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-mime all 1.2.11-1 [20.2 kB]
        ==> default: Get:22 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-form-data all 0.1.0-1 [6,412 B]
        ==> default: Get:23 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-rimraf all 2.2.2-2 [5,392 B]
        ==> default: Get:24 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-mkdirp all 0.3.5-1 [4,146 B]
        ==> default: Get:25 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-graceful-fs all 2.0.0-2 [6,718 B]
        ==> default: Get:26 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-fstream all 0.1.24-1 [19.5 kB]
        ==> default: Get:27 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-lru-cache all 2.3.1-1 [5,674 B]
        ==> default: Get:28 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-sigmund all 1.0.0-1 [3,818 B]
        ==> default: Get:29 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-minimatch all 0.2.12-1 [14.9 kB]
        ==> default: Get:30 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-fstream-ignore all 0.0.6-2 [5,586 B]
        ==> default: Get:31 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-github-url-from-git all 1.1.1-1 [3,138 B]
        ==> default: Get:32 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-glob all 3.2.6-1 [13.7 kB]
        ==> default: Get:33 http://us.archive.ubuntu.com/ubuntu/ trusty/universe nodejs-dev amd64 0.10.25~dfsg2-2ubuntu1 [169 kB]
        ==> default: Get:34 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-nopt all 2.1.2-1 [11.8 kB]
        ==> default: Get:35 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-npmlog all 0.0.4-1 [5,844 B]
        ==> default: Get:36 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-osenv all 0.0.3-1 [3,810 B]
        ==> default: Get:37 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-tunnel-agent all 0.3.1-1 [4,018 B]
        ==> default: Get:38 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-json-stringify-safe all 5.0.0-1 [3,544 B]
        ==> default: Get:39 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-qs all 0.6.5-1 [5,876 B]
        ==> default: Get:40 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-request all 2.26.1-1 [14.5 kB]
        ==> default: Get:41 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-semver all 2.1.0-2 [16.2 kB]
        ==> default: Get:42 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-tar all 0.1.18-1 [18.3 kB]
        ==> default: Get:43 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-which all 1.0.5-2 [3,678 B]
        ==> default: Get:44 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-gyp all 0.10.10-2 [22.6 kB]
        ==> default: Get:45 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-ini all 1.1.0-1 [4,770 B]
        ==> default: Get:46 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-lockfile all 0.4.1-1 [5,450 B]
        ==> default: Get:47 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-mute-stream all 0.0.3-1 [3,738 B]
        ==> default: Get:48 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-normalize-package-data all 0.2.2-1 [9,286 B]
        ==> default: Get:49 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-once all 1.1.1-1 [2,608 B]
        ==> default: Get:50 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-read all 1.0.4-1 [4,282 B]
        ==> default: Get:51 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-read-package-json all 1.1.3-1 [7,762 B]
        ==> default: Get:52 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-retry all 0.6.0-1 [6,172 B]
        ==> default: Get:53 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-sha all 1.2.3-1 [4,272 B]
        ==> default: Get:54 http://us.archive.ubuntu.com/ubuntu/ trusty/universe node-slide all 1.1.4-1 [6,118 B]
        ==> default: Get:55 http://us.archive.ubuntu.com/ubuntu/ trusty/universe npm all 1.3.10~dfsg-1 [442 kB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 3,302 kB in 8s (384 kB/s)
        ==> default: Selecting previously unselected package libc-ares2:amd64.
        ==> default: (Reading database ... 57218 files and directories currently installed.)
        ==> default: Preparing to unpack .../libc-ares2_1.10.0-2_amd64.deb ...
        ==> default: Unpacking libc-ares2:amd64 (1.10.0-2) ...
        ==> default: Selecting previously unselected package python-pkg-resources.
        ==> default: Preparing to unpack .../python-pkg-resources_3.3-1ubuntu1_all.deb ...
        ==> default: Unpacking python-pkg-resources (3.3-1ubuntu1) ...
        ==> default: Selecting previously unselected package gyp.
        ==> default: Preparing to unpack .../gyp_0.1~svn1729-3ubuntu1_all.deb ...
        ==> default: Unpacking gyp (0.1~svn1729-3ubuntu1) ...
        ==> default: Selecting previously unselected package javascript-common.
        ==> default: Preparing to unpack .../javascript-common_11_all.deb ...
        ==> default: Unpacking javascript-common (11) ...
        ==> default: Selecting previously unselected package libjs-node-uuid.
        ==> default: Preparing to unpack .../libjs-node-uuid_1.4.0-1_all.deb ...
        ==> default: Unpacking libjs-node-uuid (1.4.0-1) ...
        ==> default: Selecting previously unselected package libv8-3.14.5.
        ==> default: Preparing to unpack .../libv8-3.14.5_3.14.5.8-5ubuntu2_amd64.deb ...
        ==> default: Unpacking libv8-3.14.5 (3.14.5.8-5ubuntu2) ...
        ==> default: Selecting previously unselected package libv8-3.14-dev.
        ==> default: Preparing to unpack .../libv8-3.14-dev_3.14.5.8-5ubuntu2_amd64.deb ...
        ==> default: Unpacking libv8-3.14-dev (3.14.5.8-5ubuntu2) ...
        ==> default: Selecting previously unselected package nodejs.
        ==> default: Preparing to unpack .../nodejs_0.10.25~dfsg2-2ubuntu1_amd64.deb ...
        ==> default: Unpacking nodejs (0.10.25~dfsg2-2ubuntu1) ...
        ==> default: Selecting previously unselected package node-async.
        ==> default: Preparing to unpack .../node-async_0.2.5-1_all.deb ...
        ==> default: Unpacking node-async (0.2.5-1) ...
        ==> default: Selecting previously unselected package node-node-uuid.
        ==> default: Preparing to unpack .../node-node-uuid_1.4.0-1_all.deb ...
        ==> default: Unpacking node-node-uuid (1.4.0-1) ...
        ==> default: Selecting previously unselected package libc-ares-dev:amd64.
        ==> default: Preparing to unpack .../libc-ares-dev_1.10.0-2_amd64.deb ...
        ==> default: Unpacking libc-ares-dev:amd64 (1.10.0-2) ...
        ==> default: Selecting previously unselected package node-abbrev.
        ==> default: Preparing to unpack .../node-abbrev_1.0.4-2_all.deb ...
        ==> default: Unpacking node-abbrev (1.0.4-2) ...
        ==> default: Selecting previously unselected package node-ansi.
        ==> default: Preparing to unpack .../node-ansi_0.2.1-1_all.deb ...
        ==> default: Unpacking node-ansi (0.2.1-1) ...
        ==> default: Selecting previously unselected package node-archy.
        ==> default: Preparing to unpack .../node-archy_0.0.2-1_all.deb ...
        ==> default: Unpacking node-archy (0.0.2-1) ...
        ==> default: Selecting previously unselected package node-inherits.
        ==> default: Preparing to unpack .../node-inherits_2.0.0-1_all.deb ...
        ==> default: Unpacking node-inherits (2.0.0-1) ...
        ==> default: Selecting previously unselected package node-block-stream.
        ==> default: Preparing to unpack .../node-block-stream_0.0.7-1_all.deb ...
        ==> default: Unpacking node-block-stream (0.0.7-1) ...
        ==> default: Selecting previously unselected package node-delayed-stream.
        ==> default: Preparing to unpack .../node-delayed-stream_0.0.5-1_all.deb ...
        ==> default: Unpacking node-delayed-stream (0.0.5-1) ...
        ==> default: Selecting previously unselected package node-combined-stream.
        ==> default: Preparing to unpack .../node-combined-stream_0.0.4-1_all.deb ...
        ==> default: Unpacking node-combined-stream (0.0.4-1) ...
        ==> default: Selecting previously unselected package node-cookie-jar.
        ==> default: Preparing to unpack .../node-cookie-jar_0.3.1-1_all.deb ...
        ==> default: Unpacking node-cookie-jar (0.3.1-1) ...
        ==> default: Selecting previously unselected package node-forever-agent.
        ==> default: Preparing to unpack .../node-forever-agent_0.5.1-1_all.deb ...
        ==> default: Unpacking node-forever-agent (0.5.1-1) ...
        ==> default: Selecting previously unselected package node-mime.
        ==> default: Preparing to unpack .../node-mime_1.2.11-1_all.deb ...
        ==> default: Unpacking node-mime (1.2.11-1) ...
        ==> default: Selecting previously unselected package node-form-data.
        ==> default: Preparing to unpack .../node-form-data_0.1.0-1_all.deb ...
        ==> default: Unpacking node-form-data (0.1.0-1) ...
        ==> default: Selecting previously unselected package node-rimraf.
        ==> default: Preparing to unpack .../node-rimraf_2.2.2-2_all.deb ...
        ==> default: Unpacking node-rimraf (2.2.2-2) ...
        ==> default: Selecting previously unselected package node-mkdirp.
        ==> default: Preparing to unpack .../node-mkdirp_0.3.5-1_all.deb ...
        ==> default: Unpacking node-mkdirp (0.3.5-1) ...
        ==> default: Selecting previously unselected package node-graceful-fs.
        ==> default: Preparing to unpack .../node-graceful-fs_2.0.0-2_all.deb ...
        ==> default: Unpacking node-graceful-fs (2.0.0-2) ...
        ==> default: Selecting previously unselected package node-fstream.
        ==> default: Preparing to unpack .../node-fstream_0.1.24-1_all.deb ...
        ==> default: Unpacking node-fstream (0.1.24-1) ...
        ==> default: Selecting previously unselected package node-lru-cache.
        ==> default: Preparing to unpack .../node-lru-cache_2.3.1-1_all.deb ...
        ==> default: Unpacking node-lru-cache (2.3.1-1) ...
        ==> default: Selecting previously unselected package node-sigmund.
        ==> default: Preparing to unpack .../node-sigmund_1.0.0-1_all.deb ...
        ==> default: Unpacking node-sigmund (1.0.0-1) ...
        ==> default: Selecting previously unselected package node-minimatch.
        ==> default: Preparing to unpack .../node-minimatch_0.2.12-1_all.deb ...
        ==> default: Unpacking node-minimatch (0.2.12-1) ...
        ==> default: Selecting previously unselected package node-fstream-ignore.
        ==> default: Preparing to unpack .../node-fstream-ignore_0.0.6-2_all.deb ...
        ==> default: Unpacking node-fstream-ignore (0.0.6-2) ...
        ==> default: Selecting previously unselected package node-github-url-from-git.
        ==> default: Preparing to unpack .../node-github-url-from-git_1.1.1-1_all.deb ...
        ==> default: Unpacking node-github-url-from-git (1.1.1-1) ...
        ==> default: Selecting previously unselected package node-glob.
        ==> default: Preparing to unpack .../node-glob_3.2.6-1_all.deb ...
        ==> default: Unpacking node-glob (3.2.6-1) ...
        ==> default: Selecting previously unselected package nodejs-dev.
        ==> default: Preparing to unpack .../nodejs-dev_0.10.25~dfsg2-2ubuntu1_amd64.deb ...
        ==> default: Unpacking nodejs-dev (0.10.25~dfsg2-2ubuntu1) ...
        ==> default: Selecting previously unselected package node-nopt.
        ==> default: Preparing to unpack .../node-nopt_2.1.2-1_all.deb ...
        ==> default: Unpacking node-nopt (2.1.2-1) ...
        ==> default: Selecting previously unselected package node-npmlog.
        ==> default: Preparing to unpack .../node-npmlog_0.0.4-1_all.deb ...
        ==> default: Unpacking node-npmlog (0.0.4-1) ...
        ==> default: Selecting previously unselected package node-osenv.
        ==> default: Preparing to unpack .../node-osenv_0.0.3-1_all.deb ...
        ==> default: Unpacking node-osenv (0.0.3-1) ...
        ==> default: Selecting previously unselected package node-tunnel-agent.
        ==> default: Preparing to unpack .../node-tunnel-agent_0.3.1-1_all.deb ...
        ==> default: Unpacking node-tunnel-agent (0.3.1-1) ...
        ==> default: Selecting previously unselected package node-json-stringify-safe.
        ==> default: Preparing to unpack .../node-json-stringify-safe_5.0.0-1_all.deb ...
        ==> default: Unpacking node-json-stringify-safe (5.0.0-1) ...
        ==> default: Selecting previously unselected package node-qs.
        ==> default: Preparing to unpack .../node-qs_0.6.5-1_all.deb ...
        ==> default: Unpacking node-qs (0.6.5-1) ...
        ==> default: Selecting previously unselected package node-request.
        ==> default: Preparing to unpack .../node-request_2.26.1-1_all.deb ...
        ==> default: Unpacking node-request (2.26.1-1) ...
        ==> default: Selecting previously unselected package node-semver.
        ==> default: Preparing to unpack .../node-semver_2.1.0-2_all.deb ...
        ==> default: Unpacking node-semver (2.1.0-2) ...
        ==> default: Selecting previously unselected package node-tar.
        ==> default: Preparing to unpack .../node-tar_0.1.18-1_all.deb ...
        ==> default: Unpacking node-tar (0.1.18-1) ...
        ==> default: Selecting previously unselected package node-which.
        ==> default: Preparing to unpack .../node-which_1.0.5-2_all.deb ...
        ==> default: Unpacking node-which (1.0.5-2) ...
        ==> default: Selecting previously unselected package node-gyp.
        ==> default: Preparing to unpack .../node-gyp_0.10.10-2_all.deb ...
        ==> default: Unpacking node-gyp (0.10.10-2) ...
        ==> default: Selecting previously unselected package node-ini.
        ==> default: Preparing to unpack .../node-ini_1.1.0-1_all.deb ...
        ==> default: Unpacking node-ini (1.1.0-1) ...
        ==> default: Selecting previously unselected package node-lockfile.
        ==> default: Preparing to unpack .../node-lockfile_0.4.1-1_all.deb ...
        ==> default: Unpacking node-lockfile (0.4.1-1) ...
        ==> default: Selecting previously unselected package node-mute-stream.
        ==> default: Preparing to unpack .../node-mute-stream_0.0.3-1_all.deb ...
        ==> default: Unpacking node-mute-stream (0.0.3-1) ...
        ==> default: Selecting previously unselected package node-normalize-package-data.
        ==> default: Preparing to unpack .../node-normalize-package-data_0.2.2-1_all.deb ...
        ==> default: Unpacking node-normalize-package-data (0.2.2-1) ...
        ==> default: Selecting previously unselected package node-once.
        ==> default: Preparing to unpack .../node-once_1.1.1-1_all.deb ...
        ==> default: Unpacking node-once (1.1.1-1) ...
        ==> default: Selecting previously unselected package node-read.
        ==> default: Preparing to unpack .../node-read_1.0.4-1_all.deb ...
        ==> default: Unpacking node-read (1.0.4-1) ...
        ==> default: Selecting previously unselected package node-read-package-json.
        ==> default: Preparing to unpack .../node-read-package-json_1.1.3-1_all.deb ...
        ==> default: Unpacking node-read-package-json (1.1.3-1) ...
        ==> default: Selecting previously unselected package node-retry.
        ==> default: Preparing to unpack .../node-retry_0.6.0-1_all.deb ...
        ==> default: Unpacking node-retry (0.6.0-1) ...
        ==> default: Selecting previously unselected package node-sha.
        ==> default: Preparing to unpack .../node-sha_1.2.3-1_all.deb ...
        ==> default: Unpacking node-sha (1.2.3-1) ...
        ==> default: Selecting previously unselected package node-slide.
        ==> default: Preparing to unpack .../node-slide_1.1.4-1_all.deb ...
        ==> default: Unpacking node-slide (1.1.4-1) ...
        ==> default: Selecting previously unselected package npm.
        ==> default: Preparing to unpack .../npm_1.3.10~dfsg-1_all.deb ...
        ==> default: Unpacking npm (1.3.10~dfsg-1) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Setting up libc-ares2:amd64 (1.10.0-2) ...
        ==> default: Setting up python-pkg-resources (3.3-1ubuntu1) ...
        ==> default: Setting up gyp (0.1~svn1729-3ubuntu1) ...
        ==> default: Setting up javascript-common (11) ...
        ==> default: Setting up libjs-node-uuid (1.4.0-1) ...
        ==> default: Setting up libv8-3.14.5 (3.14.5.8-5ubuntu2) ...
        ==> default: Setting up libv8-3.14-dev (3.14.5.8-5ubuntu2) ...
        ==> default: Setting up nodejs (0.10.25~dfsg2-2ubuntu1) ...
        ==> default: update-alternatives: using /usr/bin/nodejs to provide /usr/bin/js (js) in auto mode
        ==> default: Setting up node-async (0.2.5-1) ...
        ==> default: Setting up node-node-uuid (1.4.0-1) ...
        ==> default: Setting up libc-ares-dev:amd64 (1.10.0-2) ...
        ==> default: Setting up node-abbrev (1.0.4-2) ...
        ==> default: Setting up node-ansi (0.2.1-1) ...
        ==> default: Setting up node-archy (0.0.2-1) ...
        ==> default: Setting up node-inherits (2.0.0-1) ...
        ==> default: Setting up node-block-stream (0.0.7-1) ...
        ==> default: Setting up node-delayed-stream (0.0.5-1) ...
        ==> default: Setting up node-combined-stream (0.0.4-1) ...
        ==> default: Setting up node-cookie-jar (0.3.1-1) ...
        ==> default: Setting up node-forever-agent (0.5.1-1) ...
        ==> default: Setting up node-mime (1.2.11-1) ...
        ==> default: Setting up node-form-data (0.1.0-1) ...
        ==> default: Setting up node-rimraf (2.2.2-2) ...
        ==> default: Setting up node-mkdirp (0.3.5-1) ...
        ==> default: Setting up node-graceful-fs (2.0.0-2) ...
        ==> default: Setting up node-fstream (0.1.24-1) ...
        ==> default: Setting up node-lru-cache (2.3.1-1) ...
        ==> default: Setting up node-sigmund (1.0.0-1) ...
        ==> default: Setting up node-minimatch (0.2.12-1) ...
        ==> default: Setting up node-fstream-ignore (0.0.6-2) ...
        ==> default: Setting up node-github-url-from-git (1.1.1-1) ...
        ==> default: Setting up node-glob (3.2.6-1) ...
        ==> default: Setting up nodejs-dev (0.10.25~dfsg2-2ubuntu1) ...
        ==> default: Setting up node-nopt (2.1.2-1) ...
        ==> default: Setting up node-npmlog (0.0.4-1) ...
        ==> default: Setting up node-osenv (0.0.3-1) ...
        ==> default: Setting up node-tunnel-agent (0.3.1-1) ...
        ==> default: Setting up node-json-stringify-safe (5.0.0-1) ...
        ==> default: Setting up node-qs (0.6.5-1) ...
        ==> default: Setting up node-request (2.26.1-1) ...
        ==> default: Setting up node-semver (2.1.0-2) ...
        ==> default: Setting up node-tar (0.1.18-1) ...
        ==> default: Setting up node-which (1.0.5-2) ...
        ==> default: Setting up node-gyp (0.10.10-2) ...
        ==> default: Setting up node-ini (1.1.0-1) ...
        ==> default: Setting up node-lockfile (0.4.1-1) ...
        ==> default: Setting up node-mute-stream (0.0.3-1) ...
        ==> default: Setting up node-normalize-package-data (0.2.2-1) ...
        ==> default: Setting up node-once (1.1.1-1) ...
        ==> default: Setting up node-read (1.0.4-1) ...
        ==> default: Setting up node-read-package-json (1.1.3-1) ...
        ==> default: Setting up node-retry (0.6.0-1) ...
        ==> default: Setting up node-sha (1.2.3-1) ...
        ==> default: Setting up node-slide (1.1.4-1) ...
        ==> default: Setting up npm (1.3.10~dfsg-1) ...
        ==> default: Processing triggers for libc-bin (2.19-0ubuntu6) ...
        ==> default: nodejs: v0.10.25
        ==> default: Installing Grunt cli ...
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/grunt-cli
        ==> default: npm 
        ==> default: http 
        ==> default: 200 https://registry.npmjs.org/grunt-cli
        ==> default: npm http GET https://registry.npmjs.org/grunt-cli/-/grunt-cli-0.1.13.tgz
        ==> default: npm
        ==> default:  
        ==> default: http 200
        ==> default:  https://registry.npmjs.org/grunt-cli/-/grunt-cli-0.1.13.tgz
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/resolve
        ==> default: npm http GET https://registry.npmjs.org/findup-sync
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/nopt
        ==> default: npm 
        ==> default: http
        ==> default:  200 https://registry.npmjs.org/resolve
        ==> default: npm http GET https://registry.npmjs.org/resolve/-/resolve-0.3.1.tgz
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/findup-sync
        ==> default: npm http GET https://registry.npmjs.org/findup-sync/-/findup-sync-0.1.3.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/resolve/-/resolve-0.3.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/findup-sync/-/findup-sync-0.1.3.tgz
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/nopt
        ==> default: npm http GET https://registry.npmjs.org/nopt/-/nopt-1.0.10.tgz
        ==> default: npm http 200 https://registry.npmjs.org/nopt/-/nopt-1.0.10.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/abbrev
        ==> default: npm http 
        ==> default: GET
        ==> default:  https://registry.npmjs.org/glob
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/lodash
        ==> default: npm http 200 https://registry.npmjs.org/abbrev
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/abbrev/-/abbrev-1.0.5.tgz
        ==> default: npm http 200 https://registry.npmjs.org/glob
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/glob/-/glob-3.2.11.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/lodash
        ==> default: npm http 200 https://registry.npmjs.org/abbrev/-/abbrev-1.0.5.tgz
        ==> default: npm http GET https://registry.npmjs.org/lodash/-/lodash-2.4.1.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/glob/-/glob-3.2.11.tgz
        ==> default: npm http 200 https://registry.npmjs.org/lodash/-/lodash-2.4.1.tgz
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/inherits
        ==> default: npm http GET https://registry.npmjs.org/minimatch
        ==> default: npm http 200 https://registry.npmjs.org/inherits
        ==> default: npm http GET https://registry.npmjs.org/inherits/-/inherits-2.0.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/minimatch
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/minimatch/-/minimatch-0.3.0.tgz
        ==> default: npm http
        ==> default:  
        ==> default: 200 https://registry.npmjs.org/inherits/-/inherits-2.0.1.tgz
        ==> default: npm 
        ==> default: http 200
        ==> default:  https://registry.npmjs.org/minimatch/-/minimatch-0.3.0.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/lru-cache
        ==> default: npm http GET https://registry.npmjs.org/sigmund
        ==> default: npm http 200 https://registry.npmjs.org/sigmund
        ==> default: npm http GET https://registry.npmjs.org/sigmund/-/sigmund-1.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/lru-cache
        ==> default: npm http GET https://registry.npmjs.org/lru-cache/-/lru-cache-2.5.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/sigmund/-/sigmund-1.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/lru-cache/-/lru-cache-2.5.0.tgz
        ==> default: /usr/local/bin/grunt -> /usr/local/lib/node_modules/grunt-cli/bin/grunt
        ==> default: grunt-cli@0.1.13 /usr/local/lib/node_modules/grunt-cli
        ==> default: ├── resolve@0.3.1
        ==> default: ├── nopt@1.0.10 (abbrev@1.0.5)
        ==> default: └── findup-sync@0.1.3 (lodash@2.4.1, glob@3.2.11)
        ==> default: grunt: grunt-cli v0.1.13
        ==> default: Installing Grunt cli ...
        ==> default: npm
        ==> default:  http 
        ==> default: GET https://registry.npmjs.org/bower
        ==> default: npm
        ==> default:  
        ==> default: http
        ==> default:  200 https://registry.npmjs.org/bower
        ==> default: npm http GET https://registry.npmjs.org/bower/-/bower-1.3.12.tgz
        ==> default: npm http 200 https://registry.npmjs.org/bower/-/bower-1.3.12.tgz
        ==> default: npm
        ==> default:  
        ==> default: http GET https://registry.npmjs.org/archy/0.0.2
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/bower-config
        ==> default: npm http GET https://registry.npmjs.org/bower-endpoint-parser
        ==> default: npm http GET https://registry.npmjs.org/bower-json
        ==> default: npm http GET https://registry.npmjs.org/bower-logger
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/bower-registry-client
        ==> default: npm http GET https://registry.npmjs.org/cardinal/0.4.0
        ==> default: npm http GET https://registry.npmjs.org/chalk/0.5.0
        ==> default: npm http GET https://registry.npmjs.org/chmodr/0.1.0
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/decompress-zip/0.0.8
        ==> default: npm http GET https://registry.npmjs.org/fstream
        ==> default: npm http GET https://registry.npmjs.org/fstream-ignore
        ==> default: npm http GET https://registry.npmjs.org/graceful-fs
        ==> default: npm http GET https://registry.npmjs.org/handlebars
        ==> default: npm http GET https://registry.npmjs.org/inquirer/0.7.1
        ==> default: npm http GET https://registry.npmjs.org/is-root
        ==> default: npm http GET https://registry.npmjs.org/insight/0.4.3
        ==> default: npm http GET https://registry.npmjs.org/junk
        ==> default: npm http GET https://registry.npmjs.org/lockfile
        ==> default: npm http GET https://registry.npmjs.org/mkdirp/0.5.0
        ==> default: npm 
        ==> default: http 
        ==> default: GET https://registry.npmjs.org/mout
        ==> default: npm http 
        ==> default: GET
        ==> default:  https://registry.npmjs.org/osenv/0.1.0
        ==> default: npm http 
        ==> default: GET
        ==> default:  https://registry.npmjs.org/opn
        ==> default: npm http GET https://registry.npmjs.org/promptly/0.2.0
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/p-throttler/0.1.0
        ==> default: npm http GET https://registry.npmjs.org/q
        ==> default: npm http GET https://registry.npmjs.org/request
        ==> default: npm http GET https://registry.npmjs.org/request-progress/0.3.0
        ==> default: npm http
        ==> default:  GET
        ==> default:  https://registry.npmjs.org/retry/0.6.0
        ==> default: npm http GET https://registry.npmjs.org/rimraf
        ==> default: npm http GET https://registry.npmjs.org/semver
        ==> default: npm http GET https://registry.npmjs.org/shell-quote
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/stringify-object
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/tmp/0.0.23
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/tar-fs/0.5.2
        ==> default: npm http GET https://registry.npmjs.org/update-notifier/0.2.0
        ==> default: npm http GET https://registry.npmjs.org/which
        ==> default: npm http GET https://registry.npmjs.org/glob/-/glob-4.0.6.tgz
        ==> default: npm http GET https://registry.npmjs.org/nopt/-/nopt-3.0.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/archy/0.0.2
        ==> default: npm http GET https://registry.npmjs.org/archy/-/archy-0.0.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/bower-endpoint-parser
        ==> default: npm http GET https://registry.npmjs.org/bower-endpoint-parser/-/bower-endpoint-parser-0.2.2.tgz
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/bower-json
        ==> default: npm http 200 https://registry.npmjs.org/bower-logger
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/bower-json/-/bower-json-0.4.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/cardinal/0.4.0
        ==> default: npm http 200 https://registry.npmjs.org/bower-config
        ==> default: npm http 200 https://registry.npmjs.org/bower-registry-client
        ==> default: npm http 200 https://registry.npmjs.org/chalk/0.5.0
        ==> default: npm http 200 https://registry.npmjs.org/chmodr/0.1.0
        ==> default: npm http 200 https://registry.npmjs.org/decompress-zip/0.0.8
        ==> default: npm http GET https://registry.npmjs.org/bower-logger/-/bower-logger-0.2.2.tgz
        ==> default: npm http GET https://registry.npmjs.org/bower-config/-/bower-config-0.5.2.tgz
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/cardinal/-/cardinal-0.4.0.tgz
        ==> default: npm
        ==> default:  
        ==> default: http GET https://registry.npmjs.org/bower-registry-client/-/bower-registry-client-0.2.3.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/chmodr/-/chmodr-0.1.0.tgz
        ==> default: npm http
        ==> default:  GET
        ==> default:  https://registry.npmjs.org/chalk/-/chalk-0.5.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/fstream-ignore
        ==> default: npm http GET https://registry.npmjs.org/decompress-zip/-/decompress-zip-0.0.8.tgz
        ==> default: npm http 
        ==> default: GET
        ==> default:  https://registry.npmjs.org/fstream-ignore/-/fstream-ignore-1.0.2.tgz
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/inquirer/0.7.1
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/fstream
        ==> default: npm http 200 https://registry.npmjs.org/is-root
        ==> default: npm http GET https://registry.npmjs.org/inquirer/-/inquirer-0.7.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/fstream/-/fstream-1.0.4.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/is-root/-/is-root-1.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/graceful-fs
        ==> default: npm
        ==> default:  http
        ==> default:  200 https://registry.npmjs.org/insight/0.4.3
        ==> default: npm http 200 https://registry.npmjs.org/junk
        ==> default: npm
        ==> default:  http
        ==> default:  200 https://registry.npmjs.org/lockfile
        ==> default: npm http 200 https://registry.npmjs.org/handlebars
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/mkdirp/0.5.0
        ==> default: npm http 200 https://registry.npmjs.org/archy/-/archy-0.0.2.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/nopt/-/nopt-3.0.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/glob/-/glob-4.0.6.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/graceful-fs/-/graceful-fs-3.0.5.tgz
        ==> default: npm http GET https://registry.npmjs.org/junk/-/junk-1.0.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/insight/-/insight-0.4.3.tgz
        ==> default: npm http 200 https://registry.npmjs.org/promptly/0.2.0
        ==> default: npm http 200 https://registry.npmjs.org/p-throttler/0.1.0
        ==> default: npm http 200 https://registry.npmjs.org/bower-json/-/bower-json-0.4.0.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/bower-logger/-/bower-logger-0.2.2.tgz
        ==> default: npm http GET https://registry.npmjs.org/lockfile/-/lockfile-1.0.0.tgz
        ==> default: npm 
        ==> default: http 200
        ==> default:  https://registry.npmjs.org/bower-config/-/bower-config-0.5.2.tgz
        ==> default: npm http GET https://registry.npmjs.org/handlebars/-/handlebars-2.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/bower-endpoint-parser/-/bower-endpoint-parser-0.2.2.tgz
        ==> default: npm http GET https://registry.npmjs.org/mkdirp/-/mkdirp-0.5.0.tgz
        ==> default: npm
        ==> default:  
        ==> default: http 200
        ==> default:  https://registry.npmjs.org/cardinal/-/cardinal-0.4.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/bower-registry-client/-/bower-registry-client-0.2.3.tgz
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/mout
        ==> default: npm http 200 https://registry.npmjs.org/chmodr/-/chmodr-0.1.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/promptly/-/promptly-0.2.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/p-throttler/-/p-throttler-0.1.0.tgz
        ==> default: npm
        ==> default:  http
        ==> default:  200 https://registry.npmjs.org/chalk/-/chalk-0.5.0.tgz
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/opn
        ==> default: npm http 200 https://registry.npmjs.org/decompress-zip/-/decompress-zip-0.0.8.tgz
        ==> default: npm 
        ==> default: http GET
        ==> default:  https://registry.npmjs.org/mout/-/mout-0.9.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/request-progress/0.3.0
        ==> default: npm http 200 https://registry.npmjs.org/fstream-ignore/-/fstream-ignore-1.0.2.tgz
        ==> default: npm http 
        ==> default: GET
        ==> default:  https://registry.npmjs.org/opn/-/opn-1.0.1.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/retry/0.6.0
        ==> default: npm
        ==> default:  http 
        ==> default: 200 https://registry.npmjs.org/fstream/-/fstream-1.0.4.tgz
        ==> default: npm http 200 https://registry.npmjs.org/is-root/-/is-root-1.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/inquirer/-/inquirer-0.7.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/request-progress/-/request-progress-0.3.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/graceful-fs/-/graceful-fs-3.0.5.tgz
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/retry/-/retry-0.6.0.tgz
        ==> default: npm
        ==> default:  http
        ==> default:  200 https://registry.npmjs.org/q
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/junk/-/junk-1.0.0.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/insight/-/insight-0.4.3.tgz
        ==> default: npm http 200 https://registry.npmjs.org/request
        ==> default: npm
        ==> default:  http 
        ==> default: GET https://registry.npmjs.org/q/-/q-1.0.1.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/lockfile/-/lockfile-1.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/handlebars/-/handlebars-2.0.0.tgz
        ==> default: npm 
        ==> default: http
        ==> default:  200
        ==> default:  https://registry.npmjs.org/shell-quote
        ==> default: npm http 200 https://registry.npmjs.org/promptly/-/promptly-0.2.0.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/mkdirp/-/mkdirp-0.5.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/request/-/request-2.42.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/osenv/0.1.0
        ==> default: npm http 200 https://registry.npmjs.org/rimraf
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/stringify-object
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/p-throttler/-/p-throttler-0.1.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/tmp/0.0.23
        ==> default: npm http 200 https://registry.npmjs.org/mout/-/mout-0.9.1.tgz
        ==> default: npm 
        ==> default: http 
        ==> default: GET https://registry.npmjs.org/shell-quote/-/shell-quote-1.4.2.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/opn/-/opn-1.0.1.tgz
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/semver
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/update-notifier/0.2.0
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/which
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/request-progress/-/request-progress-0.3.0.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/stringify-object/-/stringify-object-1.0.0.tgz
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/rimraf/-/rimraf-2.2.8.tgz
        ==> default: npm http 200 https://registry.npmjs.org/retry/-/retry-0.6.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/osenv/-/osenv-0.1.0.tgz
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/q/-/q-1.0.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/tmp/-/tmp-0.0.23.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/semver/-/semver-2.3.2.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/update-notifier/-/update-notifier-0.2.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/which/-/which-1.0.8.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/request/-/request-2.42.0.tgz
        ==> default: npm
        ==> default:  
        ==> default: http 200 https://registry.npmjs.org/tar-fs/0.5.2
        ==> default: npm http 200 https://registry.npmjs.org/shell-quote/-/shell-quote-1.4.2.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/stringify-object/-/stringify-object-1.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/rimraf/-/rimraf-2.2.8.tgz
        ==> default: npm http GET https://registry.npmjs.org/tar-fs/-/tar-fs-0.5.2.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/osenv/-/osenv-0.1.0.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/tmp/-/tmp-0.0.23.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/semver/-/semver-2.3.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/update-notifier/-/update-notifier-0.2.0.tgz
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/which/-/which-1.0.8.tgz
        ==> default: npm 
        ==> default: http 200
        ==> default:  https://registry.npmjs.org/tar-fs/-/tar-fs-0.5.2.tgz
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/has-ansi
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/strip-ansi
        ==> default: npm http GET https://registry.npmjs.org/supports-color
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/ansi-styles
        ==> default: npm http GET https://registry.npmjs.org/escape-string-regexp
        ==> default: npm http GET https://registry.npmjs.org/configstore
        ==> default: npm http GET https://registry.npmjs.org/latest-version
        ==> default: npm http GET https://registry.npmjs.org/semver-diff
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/string-length
        ==> default: npm http 200 https://registry.npmjs.org/supports-color
        ==> default: npm
        ==> default:  http 
        ==> default: 200 https://registry.npmjs.org/has-ansi
        ==> default: npm http GET https://registry.npmjs.org/tough-cookie
        ==> default: npm
        ==> default:  http
        ==> default:  GET https://registry.npmjs.org/object-assign
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/os-name
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/async
        ==> default: npm http GET https://registry.npmjs.org/chalk
        ==> default: npm http GET https://registry.npmjs.org/configstore
        ==> default: npm http GET https://registry.npmjs.org/inquirer
        ==> default: npm http 200 https://registry.npmjs.org/ansi-styles
        ==> default: npm http GET https://registry.npmjs.org/lodash.debounce
        ==> default: npm http 200 https://registry.npmjs.org/latest-version
        ==> default: npm http 200 https://registry.npmjs.org/strip-ansi
        ==> default: npm http 200 https://registry.npmjs.org/configstore
        ==> default: npm http 200 https://registry.npmjs.org/semver-diff
        ==> default: npm http 200 https://registry.npmjs.org/string-length
        ==> default: npm http 200 https://registry.npmjs.org/escape-string-regexp
        ==> default: npm http 200 https://registry.npmjs.org/os-name
        ==> default: npm http 200 https://registry.npmjs.org/object-assign
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/supports-color/-/supports-color-0.2.0.tgz
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/has-ansi/-/has-ansi-0.1.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/ansi-styles/-/ansi-styles-1.1.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/chalk
        ==> default: npm http GET https://registry.npmjs.org/latest-version/-/latest-version-0.2.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/strip-ansi/-/strip-ansi-0.3.0.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/configstore
        ==> default: npm http GET https://registry.npmjs.org/configstore/-/configstore-0.3.2.tgz
        ==> default: npm http GET https://registry.npmjs.org/semver-diff/-/semver-diff-0.1.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/string-length/-/string-length-0.1.2.tgz
        ==> default: npm http GET https://registry.npmjs.org/throttleit
        ==> default: npm 
        ==> default: http GET
        ==> default:  https://registry.npmjs.org/escape-string-regexp/-/escape-string-regexp-1.0.2.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/object-assign/-/object-assign-1.0.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/os-name/-/os-name-1.0.2.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/lodash.debounce
        ==> default: npm
        ==> default:  http
        ==> default:  200 https://registry.npmjs.org/inquirer
        ==> default: npm http GET https://registry.npmjs.org/chalk/-/chalk-0.5.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/tough-cookie
        ==> default: npm http 200 https://registry.npmjs.org/supports-color/-/supports-color-0.2.0.tgz
        ==> default: npm 
        ==> default: http 200
        ==> default:  https://registry.npmjs.org/has-ansi/-/has-ansi-0.1.0.tgz
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/lodash.debounce/-/lodash.debounce-2.4.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/read
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/inquirer/-/inquirer-0.6.0.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/configstore/-/configstore-0.3.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/strip-ansi/-/strip-ansi-0.3.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/semver-diff/-/semver-diff-0.1.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/latest-version/-/latest-version-0.2.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/ansi-styles/-/ansi-styles-1.1.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/string-length/-/string-length-0.1.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/escape-string-regexp/-/escape-string-regexp-1.0.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/object-assign/-/object-assign-1.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/os-name/-/os-name-1.0.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/chalk/-/chalk-0.5.1.tgz
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/throttleit
        ==> default: npm http 200 https://registry.npmjs.org/lodash.debounce/-/lodash.debounce-2.4.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/inquirer/-/inquirer-0.6.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/pump
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/tar-stream
        ==> default: npm http GET https://registry.npmjs.org/tough-cookie/-/tough-cookie-0.12.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/osenv/0.0.3
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/async
        ==> default: npm http GET https://registry.npmjs.org/optimist
        ==> default: npm http GET https://registry.npmjs.org/q/-/q-0.9.7.tgz
        ==> default: npm http GET https://registry.npmjs.org/throttleit/-/throttleit-0.0.2.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/read
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/graceful-fs/-/graceful-fs-2.0.3.tgz
        ==> default: npm http GET https://registry.npmjs.org/async/-/async-0.9.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/tough-cookie/-/tough-cookie-0.12.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/osenv/0.0.3
        ==> default: npm http GET https://registry.npmjs.org/read/-/read-1.0.5.tgz
        ==> default: npm http GET https://registry.npmjs.org/array-reduce
        ==> default: npm http 200 https://registry.npmjs.org/q/-/q-0.9.7.tgz
        ==> default: npm http GET https://registry.npmjs.org/array-map
        ==> default: npm http GET https://registry.npmjs.org/jsonify
        ==> default: npm http GET https://registry.npmjs.org/array-filter
        ==> default: npm http 200 https://registry.npmjs.org/pump
        ==> default: npm http 200 https://registry.npmjs.org/throttleit/-/throttleit-0.0.2.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/osenv/-/osenv-0.0.3.tgz
        ==> default: npm http GET https://registry.npmjs.org/inherits
        ==> default: npm http GET https://registry.npmjs.org/minimatch
        ==> default: npm http 200 https://registry.npmjs.org/jsonify
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/read/-/read-1.0.5.tgz
        ==> default: npm http GET https://registry.npmjs.org/pump/-/pump-0.3.5.tgz
        ==> default: npm
        ==> default:  http
        ==> default:  200 https://registry.npmjs.org/array-filter
        ==> default: npm http 200 https://registry.npmjs.org/optimist
        ==> default: npm http 200 https://registry.npmjs.org/graceful-fs/-/graceful-fs-2.0.3.tgz
        ==> default: npm http 304 https://registry.npmjs.org/inherits
        ==> default: npm http 304 https://registry.npmjs.org/minimatch
        ==> default: npm http 200 https://registry.npmjs.org/async/-/async-0.9.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/tar-stream
        ==> default: npm http 200 https://registry.npmjs.org/array-map
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/array-reduce
        ==> default: npm http 200 https://registry.npmjs.org/osenv/-/osenv-0.0.3.tgz
        ==> default: npm http 
        ==> default: GET
        ==> default:  https://registry.npmjs.org/jsonify/-/jsonify-0.0.0.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/pump/-/pump-0.3.5.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/array-filter/-/array-filter-0.0.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/optimist/-/optimist-0.6.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/deep-extend
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/intersect
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/minimatch/-/minimatch-2.0.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/tar-stream/-/tar-stream-0.4.7.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/mkpath
        ==> default: npm http GET https://registry.npmjs.org/binary
        ==> default: npm http GET https://registry.npmjs.org/touch/0.0.2
        ==> default: npm http GET https://registry.npmjs.org/readable-stream
        ==> default: npm http GET https://registry.npmjs.org/array-map/-/array-map-0.0.0.tgz
        ==> default: npm
        ==> default:  
        ==> default: http
        ==> default:  200 https://registry.npmjs.org/jsonify/-/jsonify-0.0.0.tgz
        ==> default: npm http
        ==> default:  GET
        ==> default:  https://registry.npmjs.org/array-reduce/-/array-reduce-0.0.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/nopt
        ==> default: npm http 200 https://registry.npmjs.org/array-map/-/array-map-0.0.0.tgz
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/array-filter/-/array-filter-0.0.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/optimist/-/optimist-0.6.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/array-reduce/-/array-reduce-0.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/deep-extend
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/minimatch/-/minimatch-2.0.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/intersect
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/tar-stream/-/tar-stream-0.4.7.tgz
        ==> default: npm 
        ==> default: http 304
        ==> default:  https://registry.npmjs.org/nopt
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/mkpath
        ==> default: npm http 200 https://registry.npmjs.org/readable-stream
        ==> default: npm http 200 https://registry.npmjs.org/binary
        ==> default: npm http GET https://registry.npmjs.org/deep-extend/-/deep-extend-0.2.11.tgz
        ==> default: npm http GET https://registry.npmjs.org/intersect/-/intersect-0.0.3.tgz
        ==> default: npm http GET https://registry.npmjs.org/minimist/0.0.8
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/nopt/-/nopt-2.2.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/mkpath/-/mkpath-0.1.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/readable-stream/-/readable-stream-1.1.13.tgz
        ==> default: npm http GET https://registry.npmjs.org/binary/-/binary-0.3.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/deep-extend/-/deep-extend-0.2.11.tgz
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/intersect/-/intersect-0.0.3.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/binary/-/binary-0.3.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/nopt/-/nopt-2.2.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/minimist/0.0.8
        ==> default: npm http 200 https://registry.npmjs.org/mkpath/-/mkpath-0.1.0.tgz
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/readable-stream/-/readable-stream-1.1.13.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/minimist/-/minimist-0.0.8.tgz
        ==> default: npm
        ==> default:  
        ==> default: http 200 https://registry.npmjs.org/minimist/-/minimist-0.0.8.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/mute-stream/0.0.4
        ==> default: npm http GET https://registry.npmjs.org/through
        ==> default: npm http GET https://registry.npmjs.org/readline2
        ==> default: npm http GET https://registry.npmjs.org/rx
        ==> default: npm http GET https://registry.npmjs.org/cli-color
        ==> default: npm http GET https://registry.npmjs.org/figures
        ==> default: npm http GET https://registry.npmjs.org/lodash
        ==> default: npm http 200 https://registry.npmjs.org/mute-stream/0.0.4
        ==> default: npm http 200 https://registry.npmjs.org/readline2
        ==> default: npm http 200 https://registry.npmjs.org/through
        ==> default: npm 
        ==> default: http 304
        ==> default:  https://registry.npmjs.org/lodash
        ==> default: npm http 200 https://registry.npmjs.org/figures
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/cli-color
        ==> default: npm http GET https://registry.npmjs.org/mute-stream/-/mute-stream-0.0.4.tgz
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/touch/0.0.2
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/through/-/through-2.3.6.tgz
        ==> default: npm http GET https://registry.npmjs.org/readline2/-/readline2-0.1.1.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/rx
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/figures/-/figures-1.3.5.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/cli-color/-/cli-color-0.3.2.tgz
        ==> default: npm 
        ==> default: http 
        ==> default: 200 https://registry.npmjs.org/mute-stream/-/mute-stream-0.0.4.tgz
        ==> default: npm http 200 https://registry.npmjs.org/through/-/through-2.3.6.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/readline2/-/readline2-0.1.1.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/touch/-/touch-0.0.2.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/rx/-/rx-2.3.24.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/js-yaml
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/user-home
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/uuid
        ==> default: npm http GET https://registry.npmjs.org/xdg-basedir
        ==> default: npm http GET https://registry.npmjs.org/ansi-regex
        ==> default: npm http GET https://registry.npmjs.org/ansi-regex
        ==> default: npm http GET https://registry.npmjs.org/package-json
        ==> default: npm http 200 https://registry.npmjs.org/figures/-/figures-1.3.5.tgz
        ==> default: npm http 200 https://registry.npmjs.org/cli-color/-/cli-color-0.3.2.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/strip-ansi/-/strip-ansi-0.2.2.tgz
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/object-assign/-/object-assign-2.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/touch/-/touch-0.0.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/rx/-/rx-2.3.24.tgz
        ==> default: npm http 200 https://registry.npmjs.org/ansi-regex
        ==> default: npm http 200 https://registry.npmjs.org/uuid
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/xdg-basedir
        ==> default: npm http 200 https://registry.npmjs.org/strip-ansi/-/strip-ansi-0.2.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/ansi-regex
        ==> default: npm http 200 https://registry.npmjs.org/js-yaml
        ==> default: npm http GET https://registry.npmjs.org/ansi-regex/-/ansi-regex-0.2.1.tgz
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/package-json
        ==> default: npm http 200 https://registry.npmjs.org/object-assign/-/object-assign-2.0.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/request-replay
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/mkdirp
        ==> default: npm http GET https://registry.npmjs.org/xdg-basedir/-/xdg-basedir-1.0.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/uuid/-/uuid-2.0.1.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/lru-cache
        ==> default: npm http GET https://registry.npmjs.org/js-yaml/-/js-yaml-3.2.5.tgz
        ==> default: npm http GET https://registry.npmjs.org/package-json/-/package-json-0.2.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/async/-/async-0.2.10.tgz
        ==> default: npm http GET https://registry.npmjs.org/request/-/request-2.51.0.tgz
        ==> default: npm
        ==> default:  http GET
        ==> default:  https://registry.npmjs.org/redeyed
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/ansi-regex/-/ansi-regex-0.2.1.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/package-json/-/package-json-0.2.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/user-home
        ==> default: npm http 200 https://registry.npmjs.org/xdg-basedir/-/xdg-basedir-1.0.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/async/-/async-0.2.10.tgz
        ==> default: npm
        ==> default:  http
        ==> default:  
        ==> default: 200 https://registry.npmjs.org/uuid/-/uuid-2.0.1.tgz
        ==> default: npm
        ==> default:  
        ==> default: http
        ==> default:  
        ==> default: 304 https://registry.npmjs.org/lru-cache
        ==> default: npm
        ==> default:  
        ==> default: http 200 https://registry.npmjs.org/mkdirp
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/request/-/request-2.51.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/request-replay
        ==> default: npm http GET https://registry.npmjs.org/user-home/-/user-home-1.1.1.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/js-yaml/-/js-yaml-3.2.5.tgz
        ==> default: npm http 200 https://registry.npmjs.org/redeyed
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/lru-cache/-/lru-cache-2.3.1.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/mkdirp/-/mkdirp-0.3.5.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/request-replay/-/request-replay-0.2.0.tgz
        ==> default: npm 
        ==> default: http 200
        ==> default:  https://registry.npmjs.org/user-home/-/user-home-1.1.1.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/request-replay/-/request-replay-0.2.0.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/redeyed/-/redeyed-0.4.4.tgz
        ==> default: npm http 200 https://registry.npmjs.org/lru-cache/-/lru-cache-2.3.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/mkdirp/-/mkdirp-0.3.5.tgz
        ==> default: npm http 200 https://registry.npmjs.org/redeyed/-/redeyed-0.4.4.tgz
        ==> default: npm http GET https://registry.npmjs.org/form-data
        ==> default: npm http GET https://registry.npmjs.org/http-signature
        ==> default: npm http GET https://registry.npmjs.org/oauth-sign
        ==> default: npm http GET https://registry.npmjs.org/hawk/1.1.1
        ==> default: npm 
        ==> default: http 
        ==> default: GET https://registry.npmjs.org/aws-sign2
        ==> default: npm http GET https://registry.npmjs.org/stringstream
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/bl
        ==> default: npm http GET https://registry.npmjs.org/caseless
        ==> default: npm http GET https://registry.npmjs.org/forever-agent
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/qs
        ==> default: npm http GET https://registry.npmjs.org/json-stringify-safe
        ==> default: npm http GET https://registry.npmjs.org/mime-types
        ==> default: npm http GET https://registry.npmjs.org/node-uuid
        ==> default: npm
        ==> default:  
        ==> default: http GET https://registry.npmjs.org/tunnel-agent
        ==> default: npm http 200 https://registry.npmjs.org/form-data
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/hawk/1.1.1
        ==> default: npm http 200 https://registry.npmjs.org/oauth-sign
        ==> default: npm http 200 https://registry.npmjs.org/http-signature
        ==> default: npm
        ==> default:  
        ==> default: http 200 https://registry.npmjs.org/stringstream
        ==> default: npm http 200 https://registry.npmjs.org/forever-agent
        ==> default: npm http 200 https://registry.npmjs.org/json-stringify-safe
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/bl
        ==> default: npm http 200 https://registry.npmjs.org/qs
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/form-data/-/form-data-0.1.4.tgz
        ==> default: npm http 200 https://registry.npmjs.org/node-uuid
        ==> default: npm http GET https://registry.npmjs.org/oauth-sign/-/oauth-sign-0.4.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/tunnel-agent
        ==> default: npm http 200 https://registry.npmjs.org/mime-types
        ==> default: npm http GET https://registry.npmjs.org/hawk/-/hawk-1.1.1.tgz
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/http-signature/-/http-signature-0.10.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/stringstream/-/stringstream-0.0.4.tgz
        ==> default: npm http GET https://registry.npmjs.org/forever-agent/-/forever-agent-0.5.2.tgz
        ==> default: npm http GET https://registry.npmjs.org/json-stringify-safe/-/json-stringify-safe-5.0.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/bl/-/bl-0.9.4.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/qs/-/qs-1.2.2.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/node-uuid/-/node-uuid-1.4.2.tgz
        ==> default: npm
        ==> default:  http 
        ==> default: 200 https://registry.npmjs.org/form-data/-/form-data-0.1.4.tgz
        ==> default: npm http GET https://registry.npmjs.org/tunnel-agent/-/tunnel-agent-0.4.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/mime-types/-/mime-types-1.0.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/oauth-sign/-/oauth-sign-0.4.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/hawk/-/hawk-1.1.1.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/http-signature/-/http-signature-0.10.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/forever-agent/-/forever-agent-0.5.2.tgz
        ==> default: npm http
        ==> default:  200
        ==> default:  https://registry.npmjs.org/json-stringify-safe/-/json-stringify-safe-5.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/stringstream/-/stringstream-0.0.4.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/bl/-/bl-0.9.4.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/qs/-/qs-1.2.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/node-uuid/-/node-uuid-1.4.2.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/tunnel-agent/-/tunnel-agent-0.4.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/mime-types/-/mime-types-1.0.2.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/caseless
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/aws-sign2
        ==> default: npm 
        ==> default: http 
        ==> default: GET https://registry.npmjs.org/caseless/-/caseless-0.6.0.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/aws-sign2/-/aws-sign2-0.5.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/caseless/-/caseless-0.6.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/aws-sign2/-/aws-sign2-0.5.0.tgz
        ==> default: npm 
        ==> default: http 
        ==> default: GET https://registry.npmjs.org/got
        ==> default: npm http GET https://registry.npmjs.org/registry-url
        ==> default: npm http GET https://registry.npmjs.org/ansi-regex/-/ansi-regex-0.1.0.tgz
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/registry-url
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/ansi-regex/-/ansi-regex-0.1.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/mute-stream
        ==> default: npm
        ==> default:  
        ==> default: http 200 https://registry.npmjs.org/got
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/registry-url/-/registry-url-0.1.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/got/-/got-0.3.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/mute-stream
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/registry-url/-/registry-url-0.1.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/got/-/got-0.3.0.tgz
        ==> default: npm
        ==> default:  http
        ==> default:  GET https://registry.npmjs.org/npmconf
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/object-assign/-/object-assign-0.3.1.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/npmconf
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/object-assign/-/object-assign-0.3.1.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/npmconf/-/npmconf-2.1.1.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/npmconf/-/npmconf-2.1.1.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/brace-expansion
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/once
        ==> default: npm http GET https://registry.npmjs.org/minimatch/-/minimatch-1.0.0.tgz
        ==> default: npm
        ==> default:  http
        ==> default:  200 https://registry.npmjs.org/brace-expansion
        ==> default: npm http 200 https://registry.npmjs.org/once
        ==> default: npm http GET https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/once/-/once-1.3.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/minimatch/-/minimatch-1.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/once/-/once-1.3.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/wordwrap
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/minimist
        ==> default: npm http 200 https://registry.npmjs.org/wordwrap
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/minimist
        ==> default: npm http GET https://registry.npmjs.org/wordwrap/-/wordwrap-0.0.2.tgz
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/minimist/-/minimist-0.0.10.tgz
        ==> default: npm http GET https://registry.npmjs.org/end-of-stream
        ==> default: npm http 200 https://registry.npmjs.org/wordwrap/-/wordwrap-0.0.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/minimist/-/minimist-0.0.10.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/once/-/once-1.2.0.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/end-of-stream
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/end-of-stream/-/end-of-stream-1.0.0.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/once/-/once-1.2.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/end-of-stream/-/end-of-stream-1.0.0.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/core-util-is
        ==> default: npm http GET https://registry.npmjs.org/isarray/0.0.1
        ==> default: npm http GET https://registry.npmjs.org/string_decoder
        ==> default: npm http 200 https://registry.npmjs.org/core-util-is
        ==> default: npm http 200 https://registry.npmjs.org/string_decoder
        ==> default: npm http 200 https://registry.npmjs.org/isarray/0.0.1
        ==> default: npm http GET https://registry.npmjs.org/core-util-is/-/core-util-is-1.0.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/string_decoder/-/string_decoder-0.10.31.tgz
        ==> default: npm http GET https://registry.npmjs.org/isarray/-/isarray-0.0.1.tgz
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/esprima
        ==> default: npm http 200 https://registry.npmjs.org/core-util-is/-/core-util-is-1.0.1.tgz
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/string_decoder/-/string_decoder-0.10.31.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/isarray/-/isarray-0.0.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/chainsaw
        ==> default: npm http GET https://registry.npmjs.org/buffers
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/esprima
        ==> default: npm http GET https://registry.npmjs.org/esprima/-/esprima-1.0.4.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/chainsaw
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/buffers
        ==> default: npm http GET https://registry.npmjs.org/chainsaw/-/chainsaw-0.1.0.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/buffers/-/buffers-0.1.1.tgz
        ==> default: npm
        ==> default:  http 200
        ==> default:  https://registry.npmjs.org/esprima/-/esprima-1.0.4.tgz
        ==> default: npm
        ==> default:  http 
        ==> default: 200 https://registry.npmjs.org/buffers/-/buffers-0.1.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/chainsaw/-/chainsaw-0.1.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/xtend
        ==> default: npm http GET https://registry.npmjs.org/readable-stream/-/readable-stream-1.0.33.tgz
        ==> default: npm http GET https://registry.npmjs.org/end-of-stream/-/end-of-stream-1.1.0.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/xtend
        ==> default: npm http 200 https://registry.npmjs.org/end-of-stream/-/end-of-stream-1.1.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/readable-stream/-/readable-stream-1.0.33.tgz
        ==> default: npm http GET https://registry.npmjs.org/xtend/-/xtend-4.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/xtend/-/xtend-4.0.0.tgz
        ==> default: npm
        ==> default:  http 
        ==> default: GET https://registry.npmjs.org/wrappy
        ==> default: npm http 200 https://registry.npmjs.org/wrappy
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/wrappy/-/wrappy-1.0.1.tgz
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/wrappy/-/wrappy-1.0.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/combined-stream
        ==> default: npm http GET https://registry.npmjs.org/form-data/-/form-data-0.2.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/qs/-/qs-2.3.3.tgz
        ==> default: npm http GET https://registry.npmjs.org/oauth-sign/-/oauth-sign-0.5.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/caseless/-/caseless-0.8.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/osx-release
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/win-release
        ==> default: npm http 200 https://registry.npmjs.org/combined-stream
        ==> default: npm http GET https://registry.npmjs.org/lodash.now
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/lodash.isfunction
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/lodash.isobject
        ==> default: npm http 200 https://registry.npmjs.org/form-data/-/form-data-0.2.0.tgz
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/minimist/-/minimist-1.1.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/oauth-sign/-/oauth-sign-0.5.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/qs/-/qs-2.3.3.tgz
        ==> default: npm http 200 https://registry.npmjs.org/caseless/-/caseless-0.8.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/combined-stream/-/combined-stream-0.0.7.tgz
        ==> default: npm
        ==> default:  
        ==> default: http 200 https://registry.npmjs.org/lodash.now
        ==> default: npm http 200 https://registry.npmjs.org/minimist/-/minimist-1.1.0.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/lodash.isfunction
        ==> default: npm http 200 https://registry.npmjs.org/combined-stream/-/combined-stream-0.0.7.tgz
        ==> default: npm http GET https://registry.npmjs.org/balanced-match
        ==> default: npm http GET https://registry.npmjs.org/concat-map/0.0.1
        ==> default: npm http GET https://registry.npmjs.org/lodash.now/-/lodash.now-2.4.1.tgz
        ==> default: npm 
        ==> default: http 
        ==> default: 200 https://registry.npmjs.org/lodash.isobject
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/lodash.isfunction/-/lodash.isfunction-2.4.1.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/win-release
        ==> default: npm http 200 https://registry.npmjs.org/balanced-match
        ==> default: npm http 200 https://registry.npmjs.org/concat-map/0.0.1
        ==> default: npm http GET https://registry.npmjs.org/lodash.isobject/-/lodash.isobject-2.4.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/win-release/-/win-release-1.0.0.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/lodash.now/-/lodash.now-2.4.1.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/lodash.isfunction/-/lodash.isfunction-2.4.1.tgz
        ==> default: npm
        ==> default:  http
        ==> default:  GET https://registry.npmjs.org/balanced-match/-/balanced-match-0.2.0.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/lodash.isobject/-/lodash.isobject-2.4.1.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/win-release/-/win-release-1.0.0.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/osx-release
        ==> default: npm
        ==> default:  
        ==> default: http 200 https://registry.npmjs.org/balanced-match/-/balanced-match-0.2.0.tgz
        ==> default: npm 
        ==> default: http 200
        ==> default:  https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz
        ==> default: npm 
        ==> default: http
        ==> default:  GET https://registry.npmjs.org/uid-number/0.0.5
        ==> default: npm http GET https://registry.npmjs.org/ini
        ==> default: npm http GET https://registry.npmjs.org/config-chain
        ==> default: npm http GET https://registry.npmjs.org/osx-release/-/osx-release-1.0.0.tgz
        ==> default: npm http GET https://registry.npmjs.org/sigmund
        ==> default: npm http GET https://registry.npmjs.org/traverse
        ==> default: npm http 200 https://registry.npmjs.org/uid-number/0.0.5
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/osx-release/-/osx-release-1.0.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/ini
        ==> default: npm http GET https://registry.npmjs.org/uid-number/-/uid-number-0.0.5.tgz
        ==> default: npm http 200 https://registry.npmjs.org/config-chain
        ==> default: npm http 304 https://registry.npmjs.org/sigmund
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/ini/-/ini-1.3.2.tgz
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/config-chain/-/config-chain-1.1.8.tgz
        ==> default: npm http 200 https://registry.npmjs.org/traverse
        ==> default: npm http 200 https://registry.npmjs.org/uid-number/-/uid-number-0.0.5.tgz
        ==> default: npm http 200 https://registry.npmjs.org/ini/-/ini-1.3.2.tgz
        ==> default: npm http GET https://registry.npmjs.org/traverse/-/traverse-0.3.9.tgz
        ==> default: npm http 200 https://registry.npmjs.org/config-chain/-/config-chain-1.1.8.tgz
        ==> default: npm http 200 https://registry.npmjs.org/traverse/-/traverse-0.3.9.tgz
        ==> default: npm http GET https://registry.npmjs.org/lodash._isnative
        ==> default: npm http
        ==> default:  
        ==> default: GET https://registry.npmjs.org/lodash._objecttypes
        ==> default: npm http 200 https://registry.npmjs.org/lodash._isnative
        ==> default: npm http 200 https://registry.npmjs.org/lodash._objecttypes
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/lodash._isnative/-/lodash._isnative-2.4.1.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/lodash._objecttypes/-/lodash._objecttypes-2.4.1.tgz
        ==> default: npm 
        ==> default: http
        ==> default:  
        ==> default: 200
        ==> default:  https://registry.npmjs.org/lodash._isnative/-/lodash._isnative-2.4.1.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/lodash._objecttypes/-/lodash._objecttypes-2.4.1.tgz
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/punycode
        ==> default: npm http 200 https://registry.npmjs.org/punycode
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/punycode/-/punycode-1.3.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/punycode/-/punycode-1.3.2.tgz
        ==> default: npm 
        ==> default: http GET
        ==> default:  https://registry.npmjs.org/mime
        ==> default: npm http GET https://registry.npmjs.org/async
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/mime
        ==> default: npm http 304 https://registry.npmjs.org/async
        ==> default: npm
        ==> default:  http
        ==> default:  GET https://registry.npmjs.org/delayed-stream/0.0.5
        ==> default: npm http GET https://registry.npmjs.org/mime/-/mime-1.2.11.tgz
        ==> default: npm http 200 https://registry.npmjs.org/delayed-stream/0.0.5
        ==> default: npm http GET https://registry.npmjs.org/mime-types/-/mime-types-2.0.7.tgz
        ==> default: npm http 200 https://registry.npmjs.org/mime/-/mime-1.2.11.tgz
        ==> default: npm http GET https://registry.npmjs.org/delayed-stream/-/delayed-stream-0.0.5.tgz
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/readable-stream
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/mime-types/-/mime-types-2.0.7.tgz
        ==> default: npm http GET https://registry.npmjs.org/ctype/0.5.3
        ==> default: npm http GET https://registry.npmjs.org/assert-plus
        ==> default: npm http GET https://registry.npmjs.org/asn1/0.1.11
        ==> default: npm http 200 https://registry.npmjs.org/delayed-stream/-/delayed-stream-0.0.5.tgz
        ==> default: npm http 304 https://registry.npmjs.org/readable-stream
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/assert-plus
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/asn1/0.1.11
        ==> default: npm http 200 https://registry.npmjs.org/ctype/0.5.3
        ==> default: npm http GET https://registry.npmjs.org/proto-list
        ==> default: npm http GET https://registry.npmjs.org/assert-plus/-/assert-plus-0.1.5.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/asn1/-/asn1-0.1.11.tgz
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/ctype/-/ctype-0.5.3.tgz
        ==> default: npm http 200 https://registry.npmjs.org/proto-list
        ==> default: npm http 200 https://registry.npmjs.org/assert-plus/-/assert-plus-0.1.5.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/asn1/-/asn1-0.1.11.tgz
        ==> default: npm
        ==> default:  http 
        ==> default: 200 https://registry.npmjs.org/ctype/-/ctype-0.5.3.tgz
        ==> default: npm http GET https://registry.npmjs.org/proto-list/-/proto-list-1.2.3.tgz
        ==> default: npm http 200 https://registry.npmjs.org/proto-list/-/proto-list-1.2.3.tgz
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/inherits
        ==> default: npm http GET https://registry.npmjs.org/mime-db
        ==> default: npm http 304 https://registry.npmjs.org/inherits
        ==> default: npm http 200 https://registry.npmjs.org/mime-db
        ==> default: npm 
        ==> default: http 
        ==> default: GET https://registry.npmjs.org/mime-db/-/mime-db-1.5.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/mime-db/-/mime-db-1.5.0.tgz
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/cryptiles
        ==> default: npm
        ==> default:  http
        ==> default:  GET https://registry.npmjs.org/sntp
        ==> default: npm http GET https://registry.npmjs.org/hoek
        ==> default: npm http GET https://registry.npmjs.org/boom
        ==> default: npm http 200 https://registry.npmjs.org/cryptiles
        ==> default: npm http 200 https://registry.npmjs.org/sntp
        ==> default: npm http 200 https://registry.npmjs.org/hoek
        ==> default: npm http GET https://registry.npmjs.org/cryptiles/-/cryptiles-0.2.2.tgz
        ==> default: npm http
        ==> default:  GET
        ==> default:  https://registry.npmjs.org/sntp/-/sntp-0.2.4.tgz
        ==> default: npm http GET https://registry.npmjs.org/hoek/-/hoek-0.9.1.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/boom
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/boom/-/boom-0.4.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/cryptiles/-/cryptiles-0.2.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/sntp/-/sntp-0.2.4.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/argparse
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/hoek/-/hoek-0.9.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/boom/-/boom-0.4.2.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/argparse
        ==> default: npm http GET https://registry.npmjs.org/argparse/-/argparse-0.1.16.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/argparse/-/argparse-0.1.16.tgz
        ==> default: npm
        ==> default:  http
        ==> default:  GET https://registry.npmjs.org/uglify-js
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/optimist
        ==> default: npm http 304 https://registry.npmjs.org/optimist
        ==> default: npm http GET https://registry.npmjs.org/optimist/-/optimist-0.3.7.tgz
        ==> default: npm http 200 https://registry.npmjs.org/uglify-js
        ==> default: npm http GET https://registry.npmjs.org/uglify-js/-/uglify-js-2.3.6.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/optimist/-/optimist-0.3.7.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/uglify-js/-/uglify-js-2.3.6.tgz
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/underscore
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/underscore.string
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/underscore.string
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/underscore.string/-/underscore.string-2.4.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/underscore
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/underscore/-/underscore-1.7.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/underscore.string/-/underscore.string-2.4.0.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/underscore/-/underscore-1.7.0.tgz
        ==> default: npm
        ==> default:  
        ==> default: http GET https://registry.npmjs.org/source-map
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/source-map
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/source-map/-/source-map-0.1.43.tgz
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/source-map/-/source-map-0.1.43.tgz
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/amdefine
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/amdefine
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/amdefine/-/amdefine-0.1.0.tgz
        ==> default: npm
        ==> default:  http
        ==> default:  200 https://registry.npmjs.org/amdefine/-/amdefine-0.1.0.tgz
        ==> default: npm
        ==> default:  
        ==> default: http GET https://registry.npmjs.org/strip-ansi
        ==> default: npm http 
        ==> default: 304 https://registry.npmjs.org/strip-ansi
        ==> default: npm http GET https://registry.npmjs.org/strip-ansi/-/strip-ansi-2.0.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/memoizee
        ==> default: npm http GET https://registry.npmjs.org/d
        ==> default: npm http GET https://registry.npmjs.org/es5-ext
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/timers-ext
        ==> default: npm http 200 https://registry.npmjs.org/strip-ansi/-/strip-ansi-2.0.1.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/d
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/timers-ext
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/d/-/d-0.1.1.tgz
        ==> default: npm http GET https://registry.npmjs.org/timers-ext/-/timers-ext-0.1.0.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/es5-ext
        ==> default: npm http GET https://registry.npmjs.org/es5-ext/-/es5-ext-0.10.5.tgz
        ==> default: npm http 200 https://registry.npmjs.org/memoizee
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/memoizee/-/memoizee-0.3.8.tgz
        ==> default: npm http 200 https://registry.npmjs.org/d/-/d-0.1.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/timers-ext/-/timers-ext-0.1.0.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/es5-ext/-/es5-ext-0.10.5.tgz
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/ansi-regex
        ==> default: npm http 200 https://registry.npmjs.org/memoizee/-/memoizee-0.3.8.tgz
        ==> default: npm http 304 https://registry.npmjs.org/ansi-regex
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/ansi-regex/-/ansi-regex-1.1.0.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/ansi-regex/-/ansi-regex-1.1.0.tgz
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/next-tick
        ==> default: npm http
        ==> default:  200 https://registry.npmjs.org/next-tick
        ==> default: npm http GET https://registry.npmjs.org/next-tick/-/next-tick-0.2.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/next-tick/-/next-tick-0.2.2.tgz
        ==> default: npm http GET https://registry.npmjs.org/es6-weak-map
        ==> default: npm http GET https://registry.npmjs.org/event-emitter
        ==> default: npm http GET https://registry.npmjs.org/lru-queue
        ==> default: npm 
        ==> default: http 200
        ==> default:  https://registry.npmjs.org/es6-weak-map
        ==> default: npm
        ==> default:  http
        ==> default:  GET https://registry.npmjs.org/es6-weak-map/-/es6-weak-map-0.1.2.tgz
        ==> default: npm 
        ==> default: http 200 https://registry.npmjs.org/event-emitter
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/event-emitter/-/event-emitter-0.3.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/lru-queue
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/lru-queue/-/lru-queue-0.1.0.tgz
        ==> default: npm 
        ==> default: http
        ==> default:  
        ==> default: 200 https://registry.npmjs.org/es6-weak-map/-/es6-weak-map-0.1.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/event-emitter/-/event-emitter-0.3.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/lru-queue/-/lru-queue-0.1.0.tgz
        ==> default: npm 
        ==> default: http GET
        ==> default:  https://registry.npmjs.org/es6-iterator
        ==> default: npm http 
        ==> default: GET
        ==> default:  https://registry.npmjs.org/es6-symbol
        ==> default: npm http 200 https://registry.npmjs.org/es6-symbol
        ==> default: npm http GET https://registry.npmjs.org/es6-symbol/-/es6-symbol-0.1.1.tgz
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/es6-iterator
        ==> default: npm http GET https://registry.npmjs.org/es6-iterator/-/es6-iterator-0.1.2.tgz
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/es6-symbol/-/es6-symbol-0.1.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/es6-iterator/-/es6-iterator-0.1.2.tgz
        ==> default: /usr/local/bin/bower -> /usr/local/lib/node_modules/bower/bin/bower
        ==> default: bower@1.3.12 /usr/local/lib/node_modules/bower
        ==> default: ├── is-root@1.0.0
        ==> default: ├── junk@1.0.0
        ==> default: ├── stringify-object@1.0.0
        ==> default: ├── which@1.0.8
        ==> default: ├── abbrev@1.0.5
        ==> default: ├── chmodr@0.1.0
        ==> default: ├── osenv@0.1.0
        ==> default: ├── archy@0.0.2
        ==> default: ├── opn@1.0.1
        ==> default: ├── rimraf@2.2.8
        ==> default: ├── bower-logger@0.2.2
        ==> default: ├── lru-cache@2.5.0
        ==> default: ├── bower-endpoint-parser@0.2.2
        ==> default: ├── graceful-fs@3.0.5
        ==> default: ├── lockfile@1.0.0
        ==> default: ├── nopt@3.0.1
        ==> default: ├── retry@0.6.0
        ==> default: ├── tmp@0.0.23
        ==> default: ├── q@1.0.1
        ==> default: ├── semver@2.3.2
        ==> default: ├── fstream@1.0.4 (inherits@2.0.1)
        ==> default: ├── request-progress@0.3.0 (throttleit@0.0.2)
        ==> default: ├── shell-quote@1.4.2 (array-filter@0.0.1, array-reduce@0.0.0, array-map@0.0.0, jsonify@0.0.0)
        ==> default: ├── bower-json@0.4.0 (intersect@0.0.3, deep-extend@0.2.11, graceful-fs@2.0.3)
        ==> default: ├── chalk@0.5.0 (escape-string-regexp@1.0.2, ansi-styles@1.1.0, supports-color@0.2.0, has-ansi@0.1.0, strip-        ansi@0.3.0)
        ==> default: ├── promptly@0.2.0 (read@1.0.5)
        ==> default: ├── mkdirp@0.5.0 (minimist@0.0.8)
        ==> default: ├── p-throttler@0.1.0 (q@0.9.7)
        ==> default: ├── bower-config@0.5.2 (osenv@0.0.3, graceful-fs@2.0.3, optimist@0.6.1)
        ==> default: ├── glob@4.0.6 (inherits@2.0.1, minimatch@1.0.0, once@1.3.1)
        ==> default: ├── fstream-ignore@1.0.2 (inherits@2.0.1, minimatch@2.0.1)
        ==> default: ├── tar-fs@0.5.2 (pump@0.3.5, tar-stream@0.4.7)
        ==> default: ├── decompress-zip@0.0.8 (nopt@2.2.1, mkpath@0.1.0, touch@0.0.2, readable-stream@1.1.13, binary@0.3.0)
        ==> default: ├── mout@0.9.1
        ==> default: ├── request@2.42.0 (caseless@0.6.0, json-stringify-safe@5.0.0, aws-sign2@0.5.0, forever-agent@0.5.2,         stringstream@0.0.4, oauth-sign@0.4.0, tunnel-agent@0.4.0, qs@1.2.2, node-uuid@1.4.2, mime-types@1.0.2, bl@0.9.4, tough-        cookie@0.12.1, form-data@0.1.4, http-signature@0.10.1, hawk@1.1.1)
        ==> default: ├── bower-registry-client@0.2.3 (graceful-fs@2.0.3, request-replay@0.2.0, lru-cache@2.3.1, async@0.2.10, mkdirp@0        .3.5, request@2.51.0)
        ==> default: ├── cardinal@0.4.0 (redeyed@0.4.4)
        ==> default: ├── update-notifier@0.2.0 (semver-diff@0.1.0, string-length@0.1.2, latest-version@0.2.0, configstore@0.3.2)
        ==> default: ├── handlebars@2.0.0 (optimist@0.3.7, uglify-js@2.3.6)
        ==> default: ├── inquirer@0.7.1 (figures@1.3.5, mute-stream@0.0.4, through@2.3.6, readline2@0.1.1, lodash@2.4.1, rx@2.3.24,         cli-color@0.3.2)
        ==> default: └── insight@0.4.3 (object-assign@1.0.0, async@0.9.0, chalk@0.5.1, lodash.debounce@2.4.1, os-name@1.0.2, tough-        cookie@0.12.1, configstore@0.3.2, inquirer@0.6.0)
        ==> default: bower: 1.3.12
        ==> default: Installing jekyll ...
        ==> default: Building native extensions.  This could take a while...
        ==> default: Successfully installed fast-stemmer-1.0.2
        ==> default: Successfully installed classifier-reborn-2.0.3
        ==> default: Building native extensions.  This could take a while...
        ==> default: Successfully installed ffi-1.9.6
        ==> default: Successfully installed rb-inotify-0.9.5
        ==> default: Successfully installed rb-fsevent-0.9.4
        ==> default: Building native extensions.  This could take a while...
        ==> default: Successfully installed hitimes-1.2.2
        ==> default: Successfully installed timers-4.0.1
        ==> default: Successfully installed celluloid-0.16.0
        ==> default: Successfully installed listen-2.8.5
        ==> default: Successfully installed jekyll-watch-1.2.1
        ==> default: Successfully installed sass-3.4.10
        ==> default: Successfully installed jekyll-sass-converter-1.3.0
        ==> default: Successfully installed coffee-script-source-1.8.0
        ==> default: Successfully installed execjs-2.2.2
        ==> default: Successfully installed coffee-script-2.3.0
        ==> default: Successfully installed jekyll-coffeescript-1.0.1
        ==> default: Successfully installed jekyll-gist-1.1.0
        ==> default: Successfully installed jekyll-paginate-1.1.0
        ==> default: Successfully installed blankslate-2.1.2.4
        ==> default: Successfully installed parslet-1.5.0
        ==> default: Successfully installed toml-0.1.2
        ==> default: Building native extensions.  This could take a while...
        ==> default: Successfully installed redcarpet-3.2.2
        ==> default: Building native extensions.  This could take a while...
        ==> default: Successfully installed yajl-ruby-1.1.0
        ==> default: Building native extensions.  This could take a while...
        ==> default: Successfully installed posix-spawn-0.3.9
        ==> default: Successfully installed pygments.rb-0.6.0
        ==> default: Successfully installed colorator-0.1
        ==> default: Successfully installed safe_yaml-1.0.4
        ==> default: Successfully installed mercenary-0.3.5
        ==> default: Successfully installed kramdown-1.5.0
        ==> default: Successfully installed liquid-2.6.2
        ==> default: Successfully installed jekyll-2.5.3
        ==> default: 31 gems installed
        ==> default: jekyll: jekyll 2.5.3
        ==> default: Installing logstash-1.4.0 ...
        ==> default:   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
        ==> default:                                  Dload  Upload   Total   Spent    Left  Speed
          0     0    0     0    0     0      0 
        ==> default:      0 --:--:-- --:--:-- --:--:--     0
          0 60.7M    0  243k    0     0   263k      0  0:03:56 --:--:--  0:03:56  262k
          3 60.7M    3 2083k    0     0  1091k      0  0:00:5
        ==> default: 6  0:00:01  0:00:55 1090k
          6 60.7M    6 4275k    0     0  1469k      0  0:00:42  0:00:02  0:00:40 1469k
         10 60.7M   10 6467k    0     0  1654k      0  0:00:37  0:00:03  0:00:34 1654k
         13 60.7M   13 8659k    0     0  1763k      0  0:00:35  0:00:04  0:00:31 1763k
         17 60.7M   17 10.5M    0     0  1836k      0  0:00:33  0:00:05  0:00:28 2128k
         20 60.7M   20 12.7M    0     0  1887k      0  0:00:32  0:00:06  0:00:26 2192k
         24 60.7M   24 14.7M    0     0  1912k      0  0:00:32  0:00:07  0:00:25 2169k
         27 60.7M   27 16.8M    0     0  1941k      0  0:00:32  0:00:08  0:00:24 2166k
         31 60.7M   31 19.0M    0     0  1968k      0  0:00:31  0:00:09  0:00:22 2169k
         34 60.7M   34 21.1M    0     0  1989k      0  0:00:31  0:00:10  0:00:21 2169k
         38 60.7M   38 23.3M    0     0  2006k      0  0:00:31  0:00:11  0:00:20 2169k
         41 60.7M   41 25.3M    0     0  2010k      0  0:00:30  0:00:12  0:00:18 2166k
         45 60.7M   45 27.4M    0     0  2023k      0  0:00:30  0:00:13  0:00:17 2169k
         48 60.7M   48 29.6M    0     0  2034k      0  0:00:30  0:00:14  0:00:16 2166k
         52 60.7M   52 31.7M    0     0  2044k      0  0:00:30  0:00:15  0:00:15 2166k
         55 60.7M   55 33.9M    0     0  2053k      0  0:00:30  0:00:16  0:00:14 2166k
         59 60.7M   59 36.0M    0     0  2061k      0  0:00:30  0:00:17  0:00:13 2192k
         62 60.7M   62 38.0M    0     0  2061k      0  0:00:30  0:00:18  0:00:12 2166k
         66 60.7M   66 40.2M    0     0  2067k      0  0:00:30  0:00:19  0:00:11 2166k
         69 60.7M   69 42.3M    0     0  2073k      0  0:00:29  0:00:20  0:00:09 2166k
         73 60.7M   73 44.4M    0     0  2079k      0  0:00:29  0:00:21  0:00:08 2166k
         76 60.7M   76 46.6M    0     0  2084k      0  0:00:29  0:00:22  0:00:07 2169k
         80 60.7M   80 48.7M    0     0  2089k      0  0:00:29  0:00:23  0:00:06 2195k
         83 60.7M   83 50.9M    0     0  2092k      0  0:00:29  0:00:24  0:00:05 2192k
         87 60.7M   87 52.9M    0     0  2092k      0  0:00:29  0:00:25  0:00:04 2169k
         90 60.7M   90 55.0M    0     0  2096k      0  0:00:29  0:00:2
        ==> default: 6  0:00:03 2169k
         94 60.7M   94 57.2M    0     0  2099k      0  0:00:29  0:00:27  0:00:02 2166k
         97 60.7M   97 59.3M    0     0  2102k      0  0:00:29  0:00:28  0:00:01 2166k
        100 60.7M  100 60.7M    0     0  2105k      0  0:00:29  0:00:29 --:--:-- 2170k
        ==> default: Installing Logstash community plugins.  This takes a few minutes...
        ==> default: Patching output/syslog plugin to support structured_data...
        ==> default:   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
        ==> default:                                  Dload  Upload   Total   Spent    Left  Speed
          0     0    0     0    0     0      0      0 --
        ==> default: :--:-- --:--:-- --:--:--     0
          0  3877    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
        100  3877  100  3877    0     0  19257      0 --:--:-- --:--:-- --:--:-- 19193
        ==> default: Ensuring logstash is in the path
        ==> default: logstash: v1.4.0
        ==> default: Installing vim...
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following extra packages will be installed:
        ==> default:   libgpm2 libpython2.7 vim-runtime
        ==> default: Suggested packages:
        ==> default:   gpm ctags vim-doc vim-scripts
        ==> default: The following NEW packages will be installed:
        ==> default:   libgpm2 libpython2.7 vim vim-runtime
        ==> default: 0 upgraded, 4 newly installed, 0 to remove and 125 not upgraded.
        ==> default: Need to get 6,904 kB of archives.
        ==> default: After this operation, 31.7 MB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/main libgpm2 amd64 1.20.4-6.1 [16.5 kB]
        ==> default: Get:2 http://us.archive.ubuntu.com/ubuntu/ trusty/main libpython2.7 amd64 2.7.6-8 [1,044 kB]
        ==> default: Get:3 http://us.archive.ubuntu.com/ubuntu/ trusty/main vim-runtime all 2:7.4.052-1ubuntu3 [4,888 kB]
        ==> default: Get:4 http://us.archive.ubuntu.com/ubuntu/ trusty/main vim amd64 2:7.4.052-1ubuntu3 [956 kB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 6,904 kB in 5s (1,368 kB/s)
        ==> default: Selecting previously unselected package libgpm2:amd64.
        ==> default: (Reading database ... 58466 files and directories currently installed.)
        ==> default: Preparing to unpack .../libgpm2_1.20.4-6.1_amd64.deb ...
        ==> default: Unpacking libgpm2:amd64 (1.20.4-6.1) ...
        ==> default: Selecting previously unselected package libpython2.7:amd64.
        ==> default: Preparing to unpack .../libpython2.7_2.7.6-8_amd64.deb ...
        ==> default: Unpacking libpython2.7:amd64 (2.7.6-8) ...
        ==> default: Selecting previously unselected package vim-runtime.
        ==> default: Preparing to unpack .../vim-runtime_2%3a7.4.052-1ubuntu3_all.deb ...
        ==> default: Adding 'diversion of /usr/share/vim/vim74/doc/help.txt to /usr/share/vim/vim74/doc/help.txt.vim-tiny by vim-        runtime'
        ==> default: Adding 'diversion of /usr/share/vim/vim74/doc/tags to /usr/share/vim/vim74/doc/tags.vim-tiny by vim-runtime'
        ==> default: Unpacking vim-runtime (2:7.4.052-1ubuntu3) ...
        ==> default: Selecting previously unselected package vim.
        ==> default: Preparing to unpack .../vim_2%3a7.4.052-1ubuntu3_amd64.deb ...
        ==> default: Unpacking vim (2:7.4.052-1ubuntu3) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Setting up libgpm2:amd64 (1.20.4-6.1) ...
        ==> default: Setting up libpython2.7:amd64 (2.7.6-8) ...
        ==> default: Setting up vim-runtime (2:7.4.052-1ubuntu3) ...
        ==> default: Processing /usr/share/vim/addons/doc
        ==> default: Setting up vim (2:7.4.052-1ubuntu3) ...
        ==> default: update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/vim (vim) in auto mode
        ==> default: update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/vimdiff (vimdiff) in auto mode
        ==> default: update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/rvim (rvim) in auto mode
        ==> default: update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/rview (rview) in auto mode
        ==> default: update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/vi (vi) in auto mode
        ==> default: update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/view (view) in auto mode
        ==> default: update-alternatives: using /usr/bin/vim.basic to provide /usr/bin/ex (ex) in auto mode
        ==> default: Processing triggers for libc-bin (2.19-0ubuntu6) ...
        ==> default: vim: VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Jan  2 2014 19:39:32)
        ==> default: Installing tig...
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following NEW packages will be installed:
        ==> default:   tig
        ==> default: 0 upgraded, 1 newly installed, 0 to remove and 125 not upgraded.
        ==> default: Need to get 216 kB of archives.
        ==> default: After this operation, 577 kB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/universe tig amd64 1.2.1-1 [216 kB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 216 kB in 0s (261 kB/s)
        ==> default: Selecting previously unselected package tig.
        ==> default: (Reading database ... 60102 files and directories currently installed.)
        ==> default: Preparing to unpack .../archives/tig_1.2.1-1_amd64.deb ...
        ==> default: Unpacking tig (1.2.1-1) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Setting up tig (1.2.1-1) ...
        ==> default: tig: tig version 1.2.1
        ==> default: Installing floomatic...
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following extra packages will be installed:
        ==> default:   fontconfig libaudio2 libdrm-dev libdrm2 libgl1-mesa-dev libglu1-mesa
        ==> default:   libglu1-mesa-dev libgstreamer-plugins-base1.0-0 libgstreamer1.0-0 libjbig0
        ==> default:   libmysqlclient18 liborc-0.4-0 libpthread-stubs0-dev libqt4-dbus
        ==> default:   libqt4-declarative libqt4-designer libqt4-dev-bin libqt4-help libqt4-network
        ==> default:   libqt4-opengl libqt4-opengl-dev libqt4-qt3support libqt4-script
        ==> default:   libqt4-scripttools libqt4-sql libqt4-sql-mysql libqt4-svg libqt4-test
        ==> default:   libqt4-xml libqt4-xmlpatterns libqtcore4 libqtdbus4 libqtgui4
        ==> default:   libqtwebkit-dev libqtwebkit4 libtiff5 libx11-dev libx11-doc libx11-xcb-dev
        ==> default:   libxau-dev libxcb-dri2-0-dev libxcb-dri3-dev libxcb-glx0-dev
        ==> default:   libxcb-present-dev libxcb-randr0 libxcb-randr0-dev libxcb-render0
        ==> default:   libxcb-render0-dev libxcb-shape0-dev libxcb-sync-dev libxcb-xfixes0
        ==> default:   libxcb-xfixes0-dev libxcb1-dev libxdamage-dev libxdmcp-dev libxext-dev
        ==> default:   libxfixes-dev libxshmfence-dev libxxf86vm-dev mesa-common-dev mysql-common
        ==> default:   qdbus qt4-linguist-tools qt4-qmake qtchooser qtcore4-l10n x11proto-core-dev
        ==> default:   x11proto-damage-dev x11proto-dri2-dev x11proto-fixes-dev x11proto-gl-dev
        ==> default:   x11proto-input-dev x11proto-kb-dev x11proto-xext-dev
        ==> default:   x11proto-xf86vidmode-dev xorg-sgml-doctools xtrans-dev
        ==> default: Suggested packages:
        ==> default:   nas libvisual-0.4-plugins gstreamer-codec-install gnome-codec-install
        ==> default:   gstreamer1.0-tools gstreamer1.0-plugins-base
        ==> default:   libqt4-declarative-folderlistmodel libqt4-declarative-gestures
        ==> default:   libqt4-declarative-particles libqt4-declarative-shaders qt4-qmlviewer
        ==> default:   firebird-dev libmysqlclient-dev libpq-dev libsqlite0-dev libsqlite3-dev
        ==> default:   qt4-dev-tools qt4-doc unixodbc-dev libicu48 libthai0 qt4-qtconfig libxcb-doc
        ==> default:   libxext-doc qt4-default qt5-default
        ==> default: The following NEW packages will be installed:
        ==> default:   fontconfig libaudio2 libdrm-dev libgl1-mesa-dev libglu1-mesa
        ==> default:   libglu1-mesa-dev libgstreamer-plugins-base1.0-0 libgstreamer1.0-0 libjbig0
        ==> default:   libmysqlclient18 liborc-0.4-0 libpthread-stubs0-dev libqt4-dbus
        ==> default:   libqt4-declarative libqt4-designer libqt4-dev libqt4-dev-bin libqt4-help
        ==> default:   libqt4-network libqt4-opengl libqt4-opengl-dev libqt4-qt3support
        ==> default:   libqt4-script libqt4-scripttools libqt4-sql libqt4-sql-mysql libqt4-svg
        ==> default:   libqt4-test libqt4-xml libqt4-xmlpatterns libqtcore4 libqtdbus4 libqtgui4
        ==> default:   libqtwebkit-dev libqtwebkit4 libtiff5 libx11-dev libx11-doc libx11-xcb-dev
        ==> default:   libxau-dev libxcb-dri2-0-dev libxcb-dri3-dev libxcb-glx0-dev
        ==> default:   libxcb-present-dev libxcb-randr0 libxcb-randr0-dev libxcb-render0
        ==> default:   libxcb-render0-dev libxcb-shape0-dev libxcb-sync-dev libxcb-xfixes0
        ==> default:   libxcb-xfixes0-dev libxcb1-dev libxdamage-dev libxdmcp-dev libxext-dev
        ==> default:   libxfixes-dev libxshmfence-dev libxxf86vm-dev mesa-common-dev mysql-common
        ==> default:   qdbus qt4-linguist-tools qt4-qmake qtchooser qtcore4-l10n x11proto-core-dev
        ==> default:   x11proto-damage-dev x11proto-dri2-dev x11proto-fixes-dev x11proto-gl-dev
        ==> default:   x11proto-input-dev x11proto-kb-dev x11proto-xext-dev
        ==> default:   x11proto-xf86vidmode-dev xorg-sgml-doctools xtrans-dev
        ==> default: The following packages will be upgraded:
        ==> default:   libdrm2
        ==> default: 1 upgraded, 77 newly installed, 0 to remove and 124 not upgraded.
        ==> default: Need to get 35.9 MB of archives.
        ==> default: After this operation, 154 MB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libdrm2 amd64 2.4.56-1~ubuntu1 [22.5 kB]
        ==> default: Get:2 http://us.archive.ubuntu.com/ubuntu/ trusty/main libaudio2 amd64 1.9.4-1 [57.1 kB]
        ==> default: Get:3 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libgstreamer1.0-0 amd64 1.2.4-0ubuntu1 [596 kB]
        ==> default: Get:4 http://us.archive.ubuntu.com/ubuntu/ trusty/main liborc-0.4-0 amd64 1:0.4.18-1ubuntu1 [136 kB]
        ==> default: Get:5 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libgstreamer-plugins-base1.0-0 amd64 1.2.4-        1~ubuntu1 [436 kB]
        ==> default: Get:6 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main mysql-common all 5.5.41-0ubuntu0.14.04.1 [14.1 kB]
        ==> default: Get:7 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libmysqlclient18 amd64 5.5.41-0ubuntu0.14.04.1 [        595 kB]
        ==> default: Get:8 http://us.archive.ubuntu.com/ubuntu/ trusty/main qtcore4-l10n all 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [        586 kB]
        ==> default: Get:9 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqtcore4 amd64 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [        1,547 kB]
        ==> default: Get:10 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-xml amd64 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [        95.1 kB]
        ==> default: Get:11 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqtdbus4 amd64 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [        180 kB]
        ==> default: Get:12 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-network amd64 4:4.8.5+git192-g085f851+dfsg-        2ubuntu4 [542 kB]
        ==> default: Get:13 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-script amd64 4:4.8.5+git192-g085f851+dfsg-        2ubuntu4 [777 kB]
        ==> default: Get:14 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-sql amd64 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [        97.6 kB]
        ==> default: Get:15 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-xmlpatterns amd64 4:4.8.5+git192-g085f851+dfsg-        2ubuntu4 [1,027 kB]
        ==> default: Get:16 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main fontconfig amd64 2.11.0-0ubuntu4.1 [176 kB]
        ==> default: Get:17 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libjbig0 amd64 2.0-2ubuntu4.1 [26.1 kB]
        ==> default: Get:18 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libtiff5 amd64 4.0.3-7ubuntu0.1 [142 kB]
        ==> default: Get:19 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqtgui4 amd64 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [        4,129 kB]
        ==> default: Get:20 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-declarative amd64 4:4.8.5+git192-g085f851+dfsg-        2ubuntu4 [1,076 kB]
        ==> default: Get:21 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-designer amd64 4:4.8.5+git192-g085f851+dfsg-        2ubuntu4 [3,599 kB]
        ==> default: Get:22 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-help amd64 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [        201 kB]
        ==> default: Get:23 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-opengl amd64 4:4.8.5+git192-g085f851+dfsg-        2ubuntu4 [296 kB]
        ==> default: Get:24 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-qt3support amd64 4:4.8.5+git192-g085f851+dfsg-        2ubuntu4 [1,029 kB]
        ==> default: Get:25 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-scripttools amd64 4:4.8.5+git192-g085f851+dfsg-        2ubuntu4 [220 kB]
        ==> default: Get:26 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-sql-mysql amd64 4:4.8.5+git192-g085f851+dfsg-        2ubuntu4 [30.3 kB]
        ==> default: Get:27 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-svg amd64 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [        137 kB]
        ==> default: Get:28 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-test amd64 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [        60.6 kB]
        ==> default: Get:29 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqtwebkit4 amd64 2.3.2-0ubuntu7 [8,561 kB]
        ==> default: Get:30 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-randr0 amd64 1.10-2ubuntu1 [13.9 kB]
        ==> default: Get:31 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-render0 amd64 1.10-2ubuntu1 [11.0 kB]
        ==> default: Get:32 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-xfixes0 amd64 1.10-2ubuntu1 [8,486 B]
        ==> default: Get:33 http://us.archive.ubuntu.com/ubuntu/ trusty/main libglu1-mesa amd64 9.0.0-2 [195 kB]
        ==> default: Get:34 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libdrm-dev amd64 2.4.56-1~ubuntu1 [169 kB]
        ==> default: Get:35 http://us.archive.ubuntu.com/ubuntu/ trusty/main xorg-sgml-doctools all 1:1.11-1 [12.9 kB]
        ==> default: Get:36 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main x11proto-core-dev all 7.0.26-1~ubuntu1 [700 kB]
        ==> default: Get:37 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxau-dev amd64 1:1.0.8-1 [11.1 kB]
        ==> default: Get:38 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxdmcp-dev amd64 1:1.1.1-1 [26.9 kB]
        ==> default: Get:39 http://us.archive.ubuntu.com/ubuntu/ trusty/main x11proto-input-dev all 2.3-1 [139 kB]
        ==> default: Get:40 http://us.archive.ubuntu.com/ubuntu/ trusty/main x11proto-kb-dev all 1.0.6-2 [269 kB]
        ==> default: Get:41 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main xtrans-dev all 1.3.4-1~ubuntu1 [70.3 kB]
        ==> default: Get:42 http://us.archive.ubuntu.com/ubuntu/ trusty/main libpthread-stubs0-dev amd64 0.3-4 [4,068 B]
        ==> default: Get:43 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb1-dev amd64 1.10-2ubuntu1 [76.6 kB]
        ==> default: Get:44 http://us.archive.ubuntu.com/ubuntu/ trusty/main libx11-dev amd64 2:1.6.2-1ubuntu2 [629 kB]
        ==> default: Get:45 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main mesa-common-dev amd64 10.1.3-0ubuntu0.3 [262 kB]
        ==> default: Get:46 http://us.archive.ubuntu.com/ubuntu/ trusty/main libx11-xcb-dev amd64 2:1.6.2-1ubuntu2 [9,758 B]
        ==> default: Get:47 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-dri3-dev amd64 1.10-2ubuntu1 [5,998 B]
        ==> default: Get:48 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-render0-dev amd64 1.10-2ubuntu1 [16.7 kB]
        ==> default: Get:49 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-randr0-dev amd64 1.10-2ubuntu1 [20.7 kB]
        ==> default: Get:50 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-shape0-dev amd64 1.10-2ubuntu1 [7,226 B]
        ==> default: Get:51 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-xfixes0-dev amd64 1.10-2ubuntu1 [12.0 kB]
        ==> default: Get:52 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-sync-dev amd64 1.10-2ubuntu1 [10.6 kB]
        ==> default: Get:53 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-present-dev amd64 1.10-2ubuntu1 [6,988 B]
        ==> default: Get:54 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxshmfence-dev amd64 1.1-2 [3,452 B]
        ==> default: Get:55 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-dri2-0-dev amd64 1.10-2ubuntu1 [9,030 B]
        ==> default: Get:56 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxcb-glx0-dev amd64 1.10-2ubuntu1 [31.2 kB]
        ==> default: Get:57 http://us.archive.ubuntu.com/ubuntu/ trusty/main x11proto-xext-dev all 7.3.0-1 [212 kB]
        ==> default: Get:58 http://us.archive.ubuntu.com/ubuntu/ trusty/main x11proto-fixes-dev all 1:5.0-2ubuntu2 [14.2 kB]
        ==> default: Get:59 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxfixes-dev amd64 1:5.0.1-1ubuntu1 [13.4 kB]
        ==> default: Get:60 http://us.archive.ubuntu.com/ubuntu/ trusty/main x11proto-damage-dev all 1:1.2.1-2 [8,286 B]
        ==> default: Get:61 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxdamage-dev amd64 1:1.1.4-1ubuntu1 [5,450 B]
        ==> default: Get:62 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxext-dev amd64 2:1.3.2-1 [92.3 kB]
        ==> default: Get:63 http://us.archive.ubuntu.com/ubuntu/ trusty/main x11proto-xf86vidmode-dev all 2.3.1-2 [6,116 B]
        ==> default: Get:64 http://us.archive.ubuntu.com/ubuntu/ trusty/main libxxf86vm-dev amd64 1:1.1.3-1 [14.6 kB]
        ==> default: Get:65 http://us.archive.ubuntu.com/ubuntu/ trusty/main x11proto-dri2-dev all 2.8-2 [12.6 kB]
        ==> default: Get:66 http://us.archive.ubuntu.com/ubuntu/ trusty/main x11proto-gl-dev all 1.4.17-1 [17.9 kB]
        ==> default: Get:67 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main libgl1-mesa-dev amd64 10.1.3-0ubuntu0.3 [5,236 B]
        ==> default: Get:68 http://us.archive.ubuntu.com/ubuntu/ trusty/main libglu1-mesa-dev amd64 9.0.0-2 [270 kB]
        ==> default: Get:69 http://us.archive.ubuntu.com/ubuntu/ trusty/main qtchooser amd64 39-g4717841-3 [18.8 kB]
        ==> default: Get:70 http://us.archive.ubuntu.com/ubuntu/ trusty/main qdbus amd64 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [28.8         kB]
        ==> default: Get:71 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-dbus amd64 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [        6,428 B]
        ==> default: Get:72 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-dev-bin amd64 4:4.8.5+git192-g085f851+dfsg-        2ubuntu4 [1,599 kB]
        ==> default: Get:73 http://us.archive.ubuntu.com/ubuntu/ trusty/main qt4-linguist-tools amd64 4:4.8.5+git192-g085f851+dfsg-        2ubuntu4 [827 kB]
        ==> default: Get:74 http://us.archive.ubuntu.com/ubuntu/ trusty/main qt4-qmake amd64 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [        1,230 kB]
        ==> default: Get:75 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-dev amd64 4:4.8.5+git192-g085f851+dfsg-2ubuntu4 [        830 kB]
        ==> default: Get:76 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqt4-opengl-dev amd64 4:4.8.5+git192-g085f851+dfsg-        2ubuntu4 [22.8 kB]
        ==> default: Get:77 http://us.archive.ubuntu.com/ubuntu/ trusty/main libqtwebkit-dev amd64 2.3.2-0ubuntu7 [70.1 kB]
        ==> default: Get:78 http://us.archive.ubuntu.com/ubuntu/ trusty/main libx11-doc all 2:1.6.2-1ubuntu2 [1,448 kB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 35.9 MB in 31s (1,144 kB/s)
        ==> default: (Reading database ... 60119 files and directories currently installed.)
        ==> default: Preparing to unpack .../libdrm2_2.4.56-1~ubuntu1_amd64.deb ...
        ==> default: Unpacking libdrm2:amd64 (2.4.56-1~ubuntu1) over (2.4.52-1) ...
        ==> default: Selecting previously unselected package libaudio2:amd64.
        ==> default: Preparing to unpack .../libaudio2_1.9.4-1_amd64.deb ...
        ==> default: Unpacking libaudio2:amd64 (1.9.4-1) ...
        ==> default: Selecting previously unselected package libgstreamer1.0-0:amd64.
        ==> default: Preparing to unpack .../libgstreamer1.0-0_1.2.4-0ubuntu1_amd64.deb ...
        ==> default: Unpacking libgstreamer1.0-0:amd64 (1.2.4-0ubuntu1) ...
        ==> default: Selecting previously unselected package liborc-0.4-0:amd64.
        ==> default: Preparing to unpack .../liborc-0.4-0_1%3a0.4.18-1ubuntu1_amd64.deb ...
        ==> default: Unpacking liborc-0.4-0:amd64 (1:0.4.18-1ubuntu1) ...
        ==> default: Selecting previously unselected package libgstreamer-plugins-base1.0-0:amd64.
        ==> default: Preparing to unpack .../libgstreamer-plugins-base1.0-0_1.2.4-1~ubuntu1_amd64.deb ...
        ==> default: Unpacking libgstreamer-plugins-base1.0-0:amd64 (1.2.4-1~ubuntu1) ...
        ==> default: Selecting previously unselected package mysql-common.
        ==> default: Preparing to unpack .../mysql-common_5.5.41-0ubuntu0.14.04.1_all.deb ...
        ==> default: Unpacking mysql-common (5.5.41-0ubuntu0.14.04.1) ...
        ==> default: Selecting previously unselected package libmysqlclient18:amd64.
        ==> default: Preparing to unpack .../libmysqlclient18_5.5.41-0ubuntu0.14.04.1_amd64.deb ...
        ==> default: Unpacking libmysqlclient18:amd64 (5.5.41-0ubuntu0.14.04.1) ...
        ==> default: Selecting previously unselected package qtcore4-l10n.
        ==> default: Preparing to unpack .../qtcore4-l10n_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_all.deb ...
        ==> default: Unpacking qtcore4-l10n (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqtcore4:amd64.
        ==> default: Preparing to unpack .../libqtcore4_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqtcore4:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-xml:amd64.
        ==> default: Preparing to unpack .../libqt4-xml_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-xml:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqtdbus4:amd64.
        ==> default: Preparing to unpack .../libqtdbus4_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqtdbus4:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-network:amd64.
        ==> default: Preparing to unpack .../libqt4-network_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-network:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-script:amd64.
        ==> default: Preparing to unpack .../libqt4-script_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-script:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-sql:amd64.
        ==> default: Preparing to unpack .../libqt4-sql_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-sql:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-xmlpatterns:amd64.
        ==> default: Preparing to unpack .../libqt4-xmlpatterns_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-xmlpatterns:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package fontconfig.
        ==> default: Preparing to unpack .../fontconfig_2.11.0-0ubuntu4.1_amd64.deb ...
        ==> default: Unpacking fontconfig (2.11.0-0ubuntu4.1) ...
        ==> default: Selecting previously unselected package libjbig0:amd64.
        ==> default: Preparing to unpack .../libjbig0_2.0-2ubuntu4.1_amd64.deb ...
        ==> default: Unpacking libjbig0:amd64 (2.0-2ubuntu4.1) ...
        ==> default: Selecting previously unselected package libtiff5:amd64.
        ==> default: Preparing to unpack .../libtiff5_4.0.3-7ubuntu0.1_amd64.deb ...
        ==> default: Unpacking libtiff5:amd64 (4.0.3-7ubuntu0.1) ...
        ==> default: Selecting previously unselected package libqtgui4:amd64.
        ==> default: Preparing to unpack .../libqtgui4_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqtgui4:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-declarative:amd64.
        ==> default: Preparing to unpack .../libqt4-declarative_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-declarative:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-designer:amd64.
        ==> default: Preparing to unpack .../libqt4-designer_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-designer:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-help:amd64.
        ==> default: Preparing to unpack .../libqt4-help_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-help:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-opengl:amd64.
        ==> default: Preparing to unpack .../libqt4-opengl_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-opengl:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-qt3support:amd64.
        ==> default: Preparing to unpack .../libqt4-qt3support_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-qt3support:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-scripttools:amd64.
        ==> default: Preparing to unpack .../libqt4-scripttools_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-scripttools:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-sql-mysql:amd64.
        ==> default: Preparing to unpack .../libqt4-sql-mysql_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-sql-mysql:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-svg:amd64.
        ==> default: Preparing to unpack .../libqt4-svg_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-svg:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-test:amd64.
        ==> default: Preparing to unpack .../libqt4-test_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-test:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqtwebkit4:amd64.
        ==> default: Preparing to unpack .../libqtwebkit4_2.3.2-0ubuntu7_amd64.deb ...
        ==> default: Unpacking libqtwebkit4:amd64 (2.3.2-0ubuntu7) ...
        ==> default: Selecting previously unselected package libxcb-randr0:amd64.
        ==> default: Preparing to unpack .../libxcb-randr0_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-randr0:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-render0:amd64.
        ==> default: Preparing to unpack .../libxcb-render0_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-render0:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-xfixes0:amd64.
        ==> default: Preparing to unpack .../libxcb-xfixes0_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-xfixes0:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libglu1-mesa:amd64.
        ==> default: Preparing to unpack .../libglu1-mesa_9.0.0-2_amd64.deb ...
        ==> default: Unpacking libglu1-mesa:amd64 (9.0.0-2) ...
        ==> default: Selecting previously unselected package libdrm-dev:amd64.
        ==> default: Preparing to unpack .../libdrm-dev_2.4.56-1~ubuntu1_amd64.deb ...
        ==> default: Unpacking libdrm-dev:amd64 (2.4.56-1~ubuntu1) ...
        ==> default: Selecting previously unselected package xorg-sgml-doctools.
        ==> default: Preparing to unpack .../xorg-sgml-doctools_1%3a1.11-1_all.deb ...
        ==> default: Unpacking xorg-sgml-doctools (1:1.11-1) ...
        ==> default: Selecting previously unselected package x11proto-core-dev.
        ==> default: Preparing to unpack .../x11proto-core-dev_7.0.26-1~ubuntu1_all.deb ...
        ==> default: Unpacking x11proto-core-dev (7.0.26-1~ubuntu1) ...
        ==> default: Selecting previously unselected package libxau-dev:amd64.
        ==> default: Preparing to unpack .../libxau-dev_1%3a1.0.8-1_amd64.deb ...
        ==> default: Unpacking libxau-dev:amd64 (1:1.0.8-1) ...
        ==> default: Selecting previously unselected package libxdmcp-dev:amd64.
        ==> default: Preparing to unpack .../libxdmcp-dev_1%3a1.1.1-1_amd64.deb ...
        ==> default: Unpacking libxdmcp-dev:amd64 (1:1.1.1-1) ...
        ==> default: Selecting previously unselected package x11proto-input-dev.
        ==> default: Preparing to unpack .../x11proto-input-dev_2.3-1_all.deb ...
        ==> default: Unpacking x11proto-input-dev (2.3-1) ...
        ==> default: Selecting previously unselected package x11proto-kb-dev.
        ==> default: Preparing to unpack .../x11proto-kb-dev_1.0.6-2_all.deb ...
        ==> default: Unpacking x11proto-kb-dev (1.0.6-2) ...
        ==> default: Selecting previously unselected package xtrans-dev.
        ==> default: Preparing to unpack .../xtrans-dev_1.3.4-1~ubuntu1_all.deb ...
        ==> default: Unpacking xtrans-dev (1.3.4-1~ubuntu1) ...
        ==> default: Selecting previously unselected package libpthread-stubs0-dev:amd64.
        ==> default: Preparing to unpack .../libpthread-stubs0-dev_0.3-4_amd64.deb ...
        ==> default: Unpacking libpthread-stubs0-dev:amd64 (0.3-4) ...
        ==> default: Selecting previously unselected package libxcb1-dev:amd64.
        ==> default: Preparing to unpack .../libxcb1-dev_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb1-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libx11-dev:amd64.
        ==> default: Preparing to unpack .../libx11-dev_2%3a1.6.2-1ubuntu2_amd64.deb ...
        ==> default: Unpacking libx11-dev:amd64 (2:1.6.2-1ubuntu2) ...
        ==> default: Selecting previously unselected package mesa-common-dev.
        ==> default: Preparing to unpack .../mesa-common-dev_10.1.3-0ubuntu0.3_amd64.deb ...
        ==> default: Unpacking mesa-common-dev (10.1.3-0ubuntu0.3) ...
        ==> default: Selecting previously unselected package libx11-xcb-dev:amd64.
        ==> default: Preparing to unpack .../libx11-xcb-dev_2%3a1.6.2-1ubuntu2_amd64.deb ...
        ==> default: Unpacking libx11-xcb-dev:amd64 (2:1.6.2-1ubuntu2) ...
        ==> default: Selecting previously unselected package libxcb-dri3-dev:amd64.
        ==> default: Preparing to unpack .../libxcb-dri3-dev_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-dri3-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-render0-dev:amd64.
        ==> default: Preparing to unpack .../libxcb-render0-dev_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-render0-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-randr0-dev:amd64.
        ==> default: Preparing to unpack .../libxcb-randr0-dev_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-randr0-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-shape0-dev:amd64.
        ==> default: Preparing to unpack .../libxcb-shape0-dev_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-shape0-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-xfixes0-dev:amd64.
        ==> default: Preparing to unpack .../libxcb-xfixes0-dev_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-xfixes0-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-sync-dev:amd64.
        ==> default: Preparing to unpack .../libxcb-sync-dev_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-sync-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-present-dev:amd64.
        ==> default: Preparing to unpack .../libxcb-present-dev_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-present-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxshmfence-dev:amd64.
        ==> default: Preparing to unpack .../libxshmfence-dev_1.1-2_amd64.deb ...
        ==> default: Unpacking libxshmfence-dev:amd64 (1.1-2) ...
        ==> default: Selecting previously unselected package libxcb-dri2-0-dev:amd64.
        ==> default: Preparing to unpack .../libxcb-dri2-0-dev_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-dri2-0-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package libxcb-glx0-dev:amd64.
        ==> default: Preparing to unpack .../libxcb-glx0-dev_1.10-2ubuntu1_amd64.deb ...
        ==> default: Unpacking libxcb-glx0-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Selecting previously unselected package x11proto-xext-dev.
        ==> default: Preparing to unpack .../x11proto-xext-dev_7.3.0-1_all.deb ...
        ==> default: Unpacking x11proto-xext-dev (7.3.0-1) ...
        ==> default: Selecting previously unselected package x11proto-fixes-dev.
        ==> default: Preparing to unpack .../x11proto-fixes-dev_1%3a5.0-2ubuntu2_all.deb ...
        ==> default: Unpacking x11proto-fixes-dev (1:5.0-2ubuntu2) ...
        ==> default: Selecting previously unselected package libxfixes-dev:amd64.
        ==> default: Preparing to unpack .../libxfixes-dev_1%3a5.0.1-1ubuntu1_amd64.deb ...
        ==> default: Unpacking libxfixes-dev:amd64 (1:5.0.1-1ubuntu1) ...
        ==> default: Selecting previously unselected package x11proto-damage-dev.
        ==> default: Preparing to unpack .../x11proto-damage-dev_1%3a1.2.1-2_all.deb ...
        ==> default: Unpacking x11proto-damage-dev (1:1.2.1-2) ...
        ==> default: Selecting previously unselected package libxdamage-dev:amd64.
        ==> default: Preparing to unpack .../libxdamage-dev_1%3a1.1.4-1ubuntu1_amd64.deb ...
        ==> default: Unpacking libxdamage-dev:amd64 (1:1.1.4-1ubuntu1) ...
        ==> default: Selecting previously unselected package libxext-dev:amd64.
        ==> default: Preparing to unpack .../libxext-dev_2%3a1.3.2-1_amd64.deb ...
        ==> default: Unpacking libxext-dev:amd64 (2:1.3.2-1) ...
        ==> default: Selecting previously unselected package x11proto-xf86vidmode-dev.
        ==> default: Preparing to unpack .../x11proto-xf86vidmode-dev_2.3.1-2_all.deb ...
        ==> default: Unpacking x11proto-xf86vidmode-dev (2.3.1-2) ...
        ==> default: Selecting previously unselected package libxxf86vm-dev:amd64.
        ==> default: Preparing to unpack .../libxxf86vm-dev_1%3a1.1.3-1_amd64.deb ...
        ==> default: Unpacking libxxf86vm-dev:amd64 (1:1.1.3-1) ...
        ==> default: Selecting previously unselected package x11proto-dri2-dev.
        ==> default: Preparing to unpack .../x11proto-dri2-dev_2.8-2_all.deb ...
        ==> default: Unpacking x11proto-dri2-dev (2.8-2) ...
        ==> default: Selecting previously unselected package x11proto-gl-dev.
        ==> default: Preparing to unpack .../x11proto-gl-dev_1.4.17-1_all.deb ...
        ==> default: Unpacking x11proto-gl-dev (1.4.17-1) ...
        ==> default: Selecting previously unselected package libgl1-mesa-dev.
        ==> default: Preparing to unpack .../libgl1-mesa-dev_10.1.3-0ubuntu0.3_amd64.deb ...
        ==> default: Unpacking libgl1-mesa-dev (10.1.3-0ubuntu0.3) ...
        ==> default: Selecting previously unselected package libglu1-mesa-dev.
        ==> default: Preparing to unpack .../libglu1-mesa-dev_9.0.0-2_amd64.deb ...
        ==> default: Unpacking libglu1-mesa-dev (9.0.0-2) ...
        ==> default: Selecting previously unselected package qtchooser.
        ==> default: Preparing to unpack .../qtchooser_39-g4717841-3_amd64.deb ...
        ==> default: Unpacking qtchooser (39-g4717841-3) ...
        ==> default: Selecting previously unselected package qdbus.
        ==> default: Preparing to unpack .../qdbus_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking qdbus (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-dbus:amd64.
        ==> default: Preparing to unpack .../libqt4-dbus_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-dbus:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-dev-bin.
        ==> default: Preparing to unpack .../libqt4-dev-bin_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-dev-bin (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package qt4-linguist-tools.
        ==> default: Preparing to unpack .../qt4-linguist-tools_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking qt4-linguist-tools (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package qt4-qmake.
        ==> default: Preparing to unpack .../qt4-qmake_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking qt4-qmake (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-dev.
        ==> default: Preparing to unpack .../libqt4-dev_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-dev (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqt4-opengl-dev.
        ==> default: Preparing to unpack .../libqt4-opengl-dev_4%3a4.8.5+git192-g085f851+dfsg-2ubuntu4_amd64.deb ...
        ==> default: Unpacking libqt4-opengl-dev (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Selecting previously unselected package libqtwebkit-dev.
        ==> default: Preparing to unpack .../libqtwebkit-dev_2.3.2-0ubuntu7_amd64.deb ...
        ==> default: Unpacking libqtwebkit-dev (2.3.2-0ubuntu7) ...
        ==> default: Selecting previously unselected package libx11-doc.
        ==> default: Preparing to unpack .../libx11-doc_2%3a1.6.2-1ubuntu2_all.deb ...
        ==> default: Unpacking libx11-doc (2:1.6.2-1ubuntu2) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Setting up libdrm2:amd64 (2.4.56-1~ubuntu1) ...
        ==> default: Setting up libaudio2:amd64 (1.9.4-1) ...
        ==> default: Setting up libgstreamer1.0-0:amd64 (1.2.4-0ubuntu1) ...
        ==> default: Setting up liborc-0.4-0:amd64 (1:0.4.18-1ubuntu1) ...
        ==> default: Setting up libgstreamer-plugins-base1.0-0:amd64 (1.2.4-1~ubuntu1) ...
        ==> default: Setting up mysql-common (5.5.41-0ubuntu0.14.04.1) ...
        ==> default: Setting up libmysqlclient18:amd64 (5.5.41-0ubuntu0.14.04.1) ...
        ==> default: Setting up qtcore4-l10n (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqtcore4:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-xml:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqtdbus4:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-network:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-script:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-sql:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-xmlpatterns:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up fontconfig (2.11.0-0ubuntu4.1) ...
        ==> default: Regenerating fonts cache... 
        ==> default: done.
        ==> default: Setting up libjbig0:amd64 (2.0-2ubuntu4.1) ...
        ==> default: Setting up libtiff5:amd64 (4.0.3-7ubuntu0.1) ...
        ==> default: Setting up libqt4-sql-mysql:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-test:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libxcb-randr0:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-render0:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-xfixes0:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libglu1-mesa:amd64 (9.0.0-2) ...
        ==> default: Setting up libdrm-dev:amd64 (2.4.56-1~ubuntu1) ...
        ==> default: Setting up xorg-sgml-doctools (1:1.11-1) ...
        ==> default: Setting up x11proto-core-dev (7.0.26-1~ubuntu1) ...
        ==> default: Setting up libxau-dev:amd64 (1:1.0.8-1) ...
        ==> default: Setting up libxdmcp-dev:amd64 (1:1.1.1-1) ...
        ==> default: Setting up x11proto-input-dev (2.3-1) ...
        ==> default: Setting up x11proto-kb-dev (1.0.6-2) ...
        ==> default: Setting up xtrans-dev (1.3.4-1~ubuntu1) ...
        ==> default: Setting up libpthread-stubs0-dev:amd64 (0.3-4) ...
        ==> default: Setting up libxcb1-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libx11-dev:amd64 (2:1.6.2-1ubuntu2) ...
        ==> default: Setting up mesa-common-dev (10.1.3-0ubuntu0.3) ...
        ==> default: Setting up libx11-xcb-dev:amd64 (2:1.6.2-1ubuntu2) ...
        ==> default: Setting up libxcb-dri3-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-render0-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-randr0-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-shape0-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-xfixes0-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-sync-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-present-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxshmfence-dev:amd64 (1.1-2) ...
        ==> default: Setting up libxcb-dri2-0-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up libxcb-glx0-dev:amd64 (1.10-2ubuntu1) ...
        ==> default: Setting up x11proto-xext-dev (7.3.0-1) ...
        ==> default: Setting up x11proto-fixes-dev (1:5.0-2ubuntu2) ...
        ==> default: Setting up libxfixes-dev:amd64 (1:5.0.1-1ubuntu1) ...
        ==> default: Setting up x11proto-damage-dev (1:1.2.1-2) ...
        ==> default: Setting up libxdamage-dev:amd64 (1:1.1.4-1ubuntu1) ...
        ==> default: Setting up libxext-dev:amd64 (2:1.3.2-1) ...
        ==> default: Setting up x11proto-xf86vidmode-dev (2.3.1-2) ...
        ==> default: Setting up libxxf86vm-dev:amd64 (1:1.1.3-1) ...
        ==> default: Setting up x11proto-dri2-dev (2.8-2) ...
        ==> default: Setting up x11proto-gl-dev (1.4.17-1) ...
        ==> default: Setting up libgl1-mesa-dev (10.1.3-0ubuntu0.3) ...
        ==> default: Setting up libglu1-mesa-dev (9.0.0-2) ...
        ==> default: Setting up qtchooser (39-g4717841-3) ...
        ==> default: Setting up qdbus (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-dbus:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up qt4-linguist-tools (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up qt4-qmake (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libx11-doc (2:1.6.2-1ubuntu2) ...
        ==> default: Setting up libqtgui4:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-declarative:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-designer:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-help:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-opengl:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-qt3support:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-scripttools:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-svg:amd64 (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqtwebkit4:amd64 (2.3.2-0ubuntu7) ...
        ==> default: Setting up libqt4-dev-bin (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-dev (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqt4-opengl-dev (4:4.8.5+git192-g085f851+dfsg-2ubuntu4) ...
        ==> default: Setting up libqtwebkit-dev (2.3.2-0ubuntu7) ...
        ==> default: Processing triggers for libc-bin (2.19-0ubuntu6) ...
        ==> default: npm
        ==> default:  
        ==> default: http GET https://registry.npmjs.org/floomatic
        ==> default: npm
        ==> default:  http
        ==> default:  200 https://registry.npmjs.org/floomatic
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/floomatic/-/floomatic-0.4.7.tgz
        ==> default: npm 
        ==> default: http 
        ==> default: 200 https://registry.npmjs.org/floomatic/-/floomatic-0.4.7.tgz
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/floorine
        ==> default: npm http GET https://registry.npmjs.org/open
        ==> default: npm http GET https://registry.npmjs.org/fsevents
        ==> default: npm http GET https://registry.npmjs.org/native-diff-match-patch
        ==> default: npm http GET https://registry.npmjs.org/diff_match_patch
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/minimatch
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/lodash
        ==> default: npm http GET https://registry.npmjs.org/mkdirp
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/optimist
        ==> default: npm http GET https://registry.npmjs.org/request
        ==> default: npm http GET https://registry.npmjs.org/async
        ==> default: npm http 200 https://registry.npmjs.org/fsevents
        ==> default: npm http GET https://registry.npmjs.org/fsevents/-/fsevents-0.3.4.tgz
        ==> default: npm http 304 https://registry.npmjs.org/minimatch
        ==> default: npm http 304 https://registry.npmjs.org/lodash
        ==> default: npm http 304 https://registry.npmjs.org/mkdirp
        ==> default: npm http 304
        ==> default:  https://registry.npmjs.org/optimist
        ==> default: npm 
        ==> default: http 200
        ==> default:  https://registry.npmjs.org/fsevents/-/fsevents-0.3.4.tgz
        ==> default: npm http 
        ==> default: 304 https://registry.npmjs.org/request
        ==> default: npm http 
        ==> default: 304 https://registry.npmjs.org/async
        ==> default: npm http 
        ==> default: 200 https://registry.npmjs.org/open
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/open/-/open-0.0.5.tgz
        ==> default: npm
        ==> default:  
        ==> default: http 
        ==> default: 200
        ==> default:  https://registry.npmjs.org/open/-/open-0.0.5.tgz
        ==> default: npm
        ==> default:  http 200 https://registry.npmjs.org/floorine
        ==> default: npm http GET https://registry.npmjs.org/floorine/-/floorine-0.2.0.tgz
        ==> default: npm http 200 https://registry.npmjs.org/native-diff-match-patch
        ==> default: npm http GET https://registry.npmjs.org/native-diff-match-patch/-/native-diff-match-patch-0.1.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/diff_match_patch
        ==> default: npm http GET https://registry.npmjs.org/diff_match_patch/-/diff_match_patch-0.1.1.tgz
        ==> default: npm http 200 https://registry.npmjs.org/floorine/-/floorine-0.2.0.tgz
        ==> default: npm
        ==> default:  
        ==> default: http 
        ==> default: 200
        ==> default:  https://registry.npmjs.org/native-diff-match-patch/-/native-diff-match-patch-0.1.2.tgz
        ==> default: npm http 200 https://registry.npmjs.org/diff_match_patch/-/diff_match_patch-0.1.1.tgz
        ==> default: npm WARN
        ==> default:  optional dep failed, continuing fsevents@0.3.4
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/strftime
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/minimist/0.0.8
        ==> default: npm http GET https://registry.npmjs.org/brace-expansion
        ==> default: npm http GET https://registry.npmjs.org/wordwrap
        ==> default: npm http GET https://registry.npmjs.org/minimist
        ==> default: npm
        ==> default:  http GET https://registry.npmjs.org/bl
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/caseless
        ==> default: npm http GET https://registry.npmjs.org/forever-agent
        ==> default: npm http GET https://registry.npmjs.org/form-data
        ==> default: npm http GET https://registry.npmjs.org/json-stringify-safe
        ==> default: npm http GET https://registry.npmjs.org/mime-types
        ==> default: npm http GET https://registry.npmjs.org/node-uuid
        ==> default: npm http GET https://registry.npmjs.org/qs
        ==> default: npm http GET https://registry.npmjs.org/tunnel-agent
        ==> default: npm http GET https://registry.npmjs.org/tough-cookie
        ==> default: npm http 304 https://registry.npmjs.org/minimist/0.0.8
        ==> default: npm http GET https://registry.npmjs.org/http-signature
        ==> default: npm http 
        ==> default: GET https://registry.npmjs.org/oauth-sign
        ==> default: npm http GET https://registry.npmjs.org/hawk/1.1.1
        ==> default: npm
        ==> default:  
        ==> default: http GET https://registry.npmjs.org/aws-sign2
        ==> default: npm http GET https://registry.npmjs.org/stringstream
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/combined-stream
        ==> default: npm http 304 https://registry.npmjs.org/brace-expansion
        ==> default: npm http 304 https://registry.npmjs.org/bl
        ==> default: npm http 304 https://registry.npmjs.org/wordwrap
        ==> default: npm http
        ==> default:  304 https://registry.npmjs.org/caseless
        ==> default: npm http 304 https://registry.npmjs.org/minimist
        ==> default: npm http 304 https://registry.npmjs.org/forever-agent
        ==> default: npm http 304 https://registry.npmjs.org/form-data
        ==> default: npm http 304 https://registry.npmjs.org/json-stringify-safe
        ==> default: npm http 304 https://registry.npmjs.org/mime-types
        ==> default: npm http 304 https://registry.npmjs.org/node-uuid
        ==> default: npm http 304 https://registry.npmjs.org/qs
        ==> default: npm http 304 https://registry.npmjs.org/tunnel-agent
        ==> default: npm http 304 https://registry.npmjs.org/tough-cookie
        ==> default: npm http 304 https://registry.npmjs.org/oauth-sign
        ==> default: npm
        ==> default:  http
        ==> default:  304 https://registry.npmjs.org/http-signature
        ==> default: npm http 304 https://registry.npmjs.org/hawk/1.1.1
        ==> default: npm http 304 https://registry.npmjs.org/aws-sign2
        ==> default: npm http 304 https://registry.npmjs.org/stringstream
        ==> default: npm http 304 https://registry.npmjs.org/combined-stream
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/delayed-stream/0.0.5
        ==> default: 
        ==> default: > native-diff-match-patch@0.1.2 install /usr/local/lib/node_modules/floomatic/node_modules/native-diff-match-        patch
        ==> default: > node-gyp rebuild
        ==> default: npm http 304 https://registry.npmjs.org/delayed-stream/0.0.5
        ==> default: npm http GET https://registry.npmjs.org/readable-stream
        ==> default: npm http GET https://registry.npmjs.org/balanced-match
        ==> default: npm http GET https://registry.npmjs.org/concat-map/0.0.1
        ==> default: npm http 200 https://registry.npmjs.org/strftime
        ==> default: npm http GET https://registry.npmjs.org/assert-plus
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/ctype/0.5.3
        ==> default: npm 
        ==> default: http 
        ==> default: GET https://registry.npmjs.org/asn1/0.1.11
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/strftime/-/strftime-0.8.2.tgz
        ==> default: npm http GET https://registry.npmjs.org/mime-db
        ==> default: npm http 304 https://registry.npmjs.org/readable-stream
        ==> default: npm http 304 https://registry.npmjs.org/balanced-match
        ==> default: npm http 304 https://registry.npmjs.org/concat-map/0.0.1
        ==> default: npm http 304 https://registry.npmjs.org/asn1/0.1.11
        ==> default: npm http 304 https://registry.npmjs.org/mime-db
        ==> default: npm http 304 https://registry.npmjs.org/assert-plus
        ==> default: npm
        ==> default:  http 304
        ==> default:  https://registry.npmjs.org/ctype/0.5.3
        ==> default: /bin/sh: 1: pkg-config: not found
        ==> default: gyp: Call to 'pkg-config --libs-only-l QtCore' returned exit status 127. while trying to load binding.gyp
        ==> default: gyp
        ==> default:  
        ==> default: ERR! configure error 
        ==> default: gyp ERR! 
        ==> default: stack Error: `gyp` failed with exit code: 1
        ==> default: gyp ERR! stack     at ChildProcess.onCpExit (/usr/share/node-gyp/lib/configure.js:431:16)
        ==> default: gyp ERR! stack     at ChildProcess.EventEmitter.emit (events.js:98:17)
        ==> default: gyp ERR! stack
        ==> default:      at Process.ChildProcess._handle.onexit (child_process.js:797:12)
        ==> default: gyp ERR!
        ==> default:  
        ==> default: System Linux 3.13.0-37-generic
        ==> default: gyp 
        ==> default: ERR! command "nodejs" "/usr/bin/node-gyp" "rebuild"
        ==> default: gyp ERR! cwd /usr/local/lib/node_modules/floomatic/node_modules/native-diff-match-patch
        ==> default: gyp ERR! node -v v0.10.25
        ==> default: gyp ERR! node-gyp -v v0.10.10
        ==> default: gyp ERR! not ok 
        ==> default: npm WARN This failure might be due to the use of legacy binary "node"
        ==> default: npm 
        ==> default: WARN For further explanations, please read
        ==> default: /usr/share/doc/nodejs/README.Debian
        ==> default:  
        ==> default: npm WARN optional dep failed, continuing
        ==> default:  native-diff-match-patch@0.1.2
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/core-util-is
        ==> default: npm 
        ==> default: http GET https://registry.npmjs.org/isarray/0.0.1
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/inherits
        ==> default: npm http
        ==> default:  GET https://registry.npmjs.org/string_decoder
        ==> default: npm
        ==> default:  
        ==> default: http 304 https://registry.npmjs.org/core-util-is
        ==> default: npm http 304 https://registry.npmjs.org/inherits
        ==> default: npm http
        ==> default:  304 https://registry.npmjs.org/isarray/0.0.1
        ==> default: npm http 304 https://registry.npmjs.org/string_decoder
        ==> default: npm http GET https://registry.npmjs.org/punycode
        ==> default: npm
        ==> default:  
        ==> default: http GET https://registry.npmjs.org/hoek
        ==> default: npm http GET
        ==> default:  https://registry.npmjs.org/boom
        ==> default: npm http GET https://registry.npmjs.org/sntp
        ==> default: npm http GET https://registry.npmjs.org/cryptiles
        ==> default: npm http 304 https://registry.npmjs.org/sntp
        ==> default: npm http 304 https://registry.npmjs.org/cryptiles
        ==> default: npm http 304 https://registry.npmjs.org/hoek
        ==> default: npm http 304 https://registry.npmjs.org/punycode
        ==> default: npm http 304 https://registry.npmjs.org/boom
        ==> default: npm http 200
        ==> default:  https://registry.npmjs.org/strftime/-/strftime-0.8.2.tgz
        ==> default: 
        ==> default: > floorine@0.2.0 install /usr/local/lib/node_modules/floomatic/node_modules/floorine
        ==> default: > 
        ==> default: /usr/local/bin/floomatic -> /usr/local/lib/node_modules/floomatic/bin/floomatic
        ==> default: floomatic@0.4.7 /usr/local/lib/node_modules/floomatic
        ==> default: ├── open@0.0.5
        ==> default: ├── async@0.9.0
        ==> default: ├── diff_match_patch@0.1.1
        ==> default: ├── mkdirp@0.5.0 (minimist@0.0.8)
        ==> default: ├── optimist@0.6.1 (wordwrap@0.0.2, minimist@0.0.10)
        ==> default: ├── minimatch@2.0.1 (brace-expansion@1.1.0)
        ==> default: ├── lodash@2.4.1
        ==> default: ├── request@2.51.0 (caseless@0.8.0, json-stringify-safe@5.0.0, forever-agent@0.5.2, aws-sign2@0.5.0,         stringstream@0.0.4, oauth-sign@0.5.0, tunnel-agent@0.4.0, node-uuid@1.4.2, qs@2.3.3, mime-types@1.0.2, combined-stream@0.0.7,         form-data@0.2.0, http-signature@0.10.1, bl@0.9.4, tough-cookie@0.12.1, hawk@1.1.1)
        ==> default: └── floorine@0.2.0 (strftime@0.8.2)
        ==> default: floomatic: installed
        ==> default: Installing aws cli...
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following NEW packages will be installed:
        ==> default:   jq
        ==> default: 0 upgraded, 1 newly installed, 0 to remove and 124 not upgraded.
        ==> default: Need to get 97.8 kB of archives.
        ==> default: After this operation, 296 kB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/universe jq amd64 1.3-1.1ubuntu1 [97.8 kB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 97.8 kB in 0s (210 kB/s)
        ==> default: Selecting previously unselected package jq.
        ==> default: (Reading database ... 65964 files and directories currently installed.)
        ==> default: Preparing to unpack .../jq_1.3-1.1ubuntu1_amd64.deb ...
        ==> default: Unpacking jq (1.3-1.1ubuntu1) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Setting up jq (1.3-1.1ubuntu1) ...
        ==> default: jq: jq version 1.3
        ==> default: Installing htop...
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following NEW packages will be installed:
        ==> default:   htop
        ==> default: 0 upgraded, 1 newly installed, 0 to remove and 124 not upgraded.
        ==> default: Need to get 68.0 kB of archives.
        ==> default: After this operation, 188 kB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/universe htop amd64 1.0.2-3 [68.0 kB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 68.0 kB in 0s (147 kB/s)
        ==> default: Selecting previously unselected package htop.
        ==> default: (Reading database ... 65971 files and directories currently installed.)
        ==> default: Preparing to unpack .../htop_1.0.2-3_amd64.deb ...
        ==> default: Unpacking htop (1.0.2-3) ...
        ==> default: Processing triggers for mime-support (3.54ubuntu1) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Setting up htop (1.0.2-3) ...
        ==> default: htop: htop 1.0.2 - (C) 2004-2011 Hisham Muhammad
        ==> default: Installing tree...
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following NEW packages will be installed:
        ==> default:   tree
        ==> default: 0 upgraded, 1 newly installed, 0 to remove and 124 not upgraded.
        ==> default: Need to get 37.8 kB of archives.
        ==> default: After this operation, 109 kB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/universe tree amd64 1.6.0-1 [37.8 kB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 37.8 kB in 0s (102 kB/s)
        ==> default: Selecting previously unselected package tree.
        ==> default: (Reading database ... 65981 files and directories currently installed.)
        ==> default: Preparing to unpack .../tree_1.6.0-1_amd64.deb ...
        ==> default: Unpacking tree (1.6.0-1) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Setting up tree (1.6.0-1) ...
        ==> default: tree: tree v1.6.0 (c) 1996 - 2011 by Steve Baker, Thomas Moore, Francesc Rocher, Kyosuke Tokoro 
        ==> default: Installing Rake...
        ==> default: Successfully installed rake-10.4.2
        ==> default: 1 gem installed
        ==> default: rake: rake, version 10.4.2
        ==> default: Patching bosh_cli to add string diffing of changesets
        ==> default: Successfully installed diff-lcs-1.2.5
        ==> default: 1 gem installed
        ==> default: patching file lib/cli/changeset_helper.rb
        ==> default: bosh_cli: Patched to add string diffing of changesets
        ==> default: Installing aws cli...
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following extra packages will be installed:
        ==> default:   python-colorama python-distlib python-html5lib python-setuptools
        ==> default: Suggested packages:
        ==> default:   python-lxml python-genshi
        ==> default: Recommended packages:
        ==> default:   python-dev-all
        ==> default: The following NEW packages will be installed:
        ==> default:   python-colorama python-distlib python-html5lib python-pip python-setuptools
        ==> default: 0 upgraded, 5 newly installed, 0 to remove and 124 not upgraded.
        ==> default: Need to get 542 kB of archives.
        ==> default: After this operation, 2,513 kB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/universe python-colorama all 0.2.5-0.1ubuntu1 [18.3 kB]
        ==> default: Get:2 http://us.archive.ubuntu.com/ubuntu/ trusty/universe python-distlib all 0.1.8-1 [113 kB]
        ==> default: Get:3 http://us.archive.ubuntu.com/ubuntu/ trusty/main python-html5lib all 0.999-2 [83.2 kB]
        ==> default: Get:4 http://us.archive.ubuntu.com/ubuntu/ trusty/main python-setuptools all 3.3-1ubuntu1 [230 kB]
        ==> default: Get:5 http://us.archive.ubuntu.com/ubuntu/ trusty/universe python-pip all 1.5.4-1 [97.7 kB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 542 kB in 1s (440 kB/s)
        ==> default: Selecting previously unselected package python-colorama.
        ==> default: (Reading database ... 65988 files and directories currently installed.)
        ==> default: Preparing to unpack .../python-colorama_0.2.5-0.1ubuntu1_all.deb ...
        ==> default: Unpacking python-colorama (0.2.5-0.1ubuntu1) ...
        ==> default: Selecting previously unselected package python-distlib.
        ==> default: Preparing to unpack .../python-distlib_0.1.8-1_all.deb ...
        ==> default: Unpacking python-distlib (0.1.8-1) ...
        ==> default: Selecting previously unselected package python-html5lib.
        ==> default: Preparing to unpack .../python-html5lib_0.999-2_all.deb ...
        ==> default: Unpacking python-html5lib (0.999-2) ...
        ==> default: Selecting previously unselected package python-setuptools.
        ==> default: Preparing to unpack .../python-setuptools_3.3-1ubuntu1_all.deb ...
        ==> default: Unpacking python-setuptools (3.3-1ubuntu1) ...
        ==> default: Selecting previously unselected package python-pip.
        ==> default: Preparing to unpack .../python-pip_1.5.4-1_all.deb ...
        ==> default: Unpacking python-pip (1.5.4-1) ...
        ==> default: Processing triggers for man-db (2.6.7.1-1) ...
        ==> default: Setting up python-colorama (0.2.5-0.1ubuntu1) ...
        ==> default: Setting up python-distlib (0.1.8-1) ...
        ==> default: Setting up python-html5lib (0.999-2) ...
        ==> default: Setting up python-setuptools (3.3-1ubuntu1) ...
        ==> default: Setting up python-pip (1.5.4-1) ...
        ==> default: Downloading/unpacking awscli
        ==> default:   Running setup.py (path:/tmp/pip_build_root/awscli/setup.py) egg_info for package awscli
        ==> default:     
        ==> default: Downloading/unpacking httpie
        ==> default: Downloading/unpacking botocore>=0.84.0,<0.85.0 (from awscli)
        ==> default:   Running setup.py (path:/tmp/pip_build_root/botocore/setup.py) egg_info for package botocore
        ==> default:     
        ==> default: Downloading/unpacking bcdoc>=0.12.0,<0.13.0 (from awscli)
        ==> default:   Downloading bcdoc-0.12.2.tar.gz
        ==> default:   Running setup.py (path:/tmp/pip_build_root/bcdoc/setup.py) egg_info for package bcdoc
        ==> default:     
        ==> default:     warning: no files found matching 'README.md'
        ==> default: Requirement already up-to-date: colorama==0.2.5 in /usr/lib/python2.7/dist-packages (from awscli)
        ==> default: Downloading/unpacking docutils>=0.10 (from awscli)
        ==> default:   Running setup.py (path:/tmp/pip_build_root/docutils/setup.py) egg_info for package docutils
        ==> default:     
        ==> default:     warning: no files found matching 'MANIFEST'
        ==> default:     warning: no files found matching '*' under directory 'extras'
        ==> default:     warning: no previously-included files matching '.cvsignore' found under directory '*'
        ==> default:     warning: no previously-included files matching '*.pyc' found under directory '*'
        ==> default:     warning: no previously-included files matching '*~' found under directory '*'
        ==> default:     warning: no previously-included files matching '.DS_Store' found under directory '*'
        ==> default: Downloading/unpacking rsa==3.1.2 (from awscli)
        ==> default:   Downloading rsa-3.1.2.tar.gz
        ==> default:   Running setup.py (path:/tmp/pip_build_root/rsa/setup.py) egg_info for package rsa
        ==> default:     
        ==> default:     warning: no files found matching 'README'
        ==> default: Downloading/unpacking Pygments>=1.5 (from httpie)
        ==> default: Downloading/unpacking requests>=2.0.0 from https://pypi.python.org/packages/py2.py3/r/requests/requests-2.5.1-py2        .py3-none-any.whl#md5=11dc91bc96c5c5e0b566ce8f9c9644ab (from httpie)
        ==> default: Downloading/unpacking jmespath==0.5.0 (from botocore>=0.84.0,<0.85.0->awscli)
        ==> default:   Downloading jmespath-0.5.0.tar.gz
        ==> default:   Running setup.py (path:/tmp/pip_build_root/jmespath/setup.py) egg_info for package jmespath
        ==> default:     
        ==> default: Downloading/unpacking python-dateutil>=2.1,<3.0.0 (from botocore>=0.84.0,<0.85.0->awscli)
        ==> default: Downloading/unpacking six>=1.1.0 from https://pypi.python.org/packages/3.3/s/six/six-1.9.0-py2.py3-none-any.        whl#md5=9ac7e129a80f72d6fc1f0216f6e9627b (from bcdoc>=0.12.0,<0.13.0->awscli)
        ==> default:   Downloading six-1.9.0-py2.py3-none-any.whl
        ==> default: Downloading/unpacking pyasn1>=0.1.3 (from rsa==3.1.2->awscli)
        ==> default:   Running setup.py (path:/tmp/pip_build_root/pyasn1/setup.py) egg_info for package pyasn1
        ==> default:     
        ==> default: Installing collected packages: awscli, httpie, botocore, bcdoc, docutils, rsa, Pygments, requests, jmespath,         python-dateutil, six, pyasn1
        ==> default:   Running setup.py install for awscli
        ==> default:     changing mode of build/scripts-2.7/aws from 644 to 755
        ==> default:     changing mode of build/scripts-2.7/aws.cmd from 644 to 755
        ==> default:     changing mode of build/scripts-2.7/aws_completer from 644 to 755
        ==> default:     changing mode of build/scripts-2.7/aws_zsh_completer.sh from 644 to 755
        ==> default:     
        ==> default:     changing mode of /usr/local/bin/aws to 755
        ==> default:     changing mode of /usr/local/bin/aws.cmd to 755
        ==> default:     changing mode of /usr/local/bin/aws_completer to 755
        ==> default:     changing mode of /usr/local/bin/aws_zsh_completer.sh to 755
        ==> default:   Running setup.py install for botocore
        ==> default:     
        ==> default:   Running setup.py install for bcdoc
        ==> default:     
        ==> default:     warning: no files found matching 'README.md'
        ==> default:   Running setup.py install for docutils
        ==> default:     changing mode of build/scripts-2.7/rst2html.py from 644 to 755
        ==> default:     changing mode of build/scripts-2.7/rst2s5.py from 644 to 755
        ==> default:     changing mode of build/scripts-2.7/rst2latex.py from 644 to 755
        ==> default:     changing mode of build/scripts-2.7/rst2xetex.py from 644 to 755
        ==> default:     changing mode of build/scripts-2.7/rst2man.py from 644 to 755
        ==> default:     changing mode of build/scripts-2.7/rst2xml.py from 644 to 755
        ==> default:     changing mode of build/scripts-2.7/rst2pseudoxml.py from 644 to 755
        ==> default:     changing mode of build/scripts-2.7/rstpep2html.py from 644 to 755
        ==> default:     changing mode of build/scripts-2.7/rst2odt.py from 644 to 755
        ==> default:     changing mode of build/scripts-2.7/rst2odt_prepstyles.py from 644 to 755
        ==> default:     
        ==> default:     warning: no files found matching 'MANIFEST'
        ==> default:     warning: no files found matching '*' under directory 'extras'
        ==> default:     warning: no previously-included files matching '.cvsignore' found under directory '*'
        ==> default:     warning: no previously-included files matching '*.pyc' found under directory '*'
        ==> default:     warning: no previously-included files matching '*~' found under directory '*'
        ==> default:     warning: no previously-included files matching '.DS_Store' found under directory '*'
        ==> default:     changing mode of /usr/local/bin/rst2pseudoxml.py to 755
        ==> default:     changing mode of /usr/local/bin/rst2man.py to 755
        ==> default:     changing mode of /usr/local/bin/rst2odt_prepstyles.py to 755
        ==> default:     changing mode of /usr/local/bin/rst2odt.py to 755
        ==> default:     changing mode of /usr/local/bin/rst2html.py to 755
        ==> default:     changing mode of /usr/local/bin/rst2xml.py to 755
        ==> default:     changing mode of /usr/local/bin/rst2s5.py to 755
        ==> default:     changing mode of /usr/local/bin/rst2xetex.py to 755
        ==> default:     changing mode of /usr/local/bin/rst2latex.py to 755
        ==> default:     changing mode of /usr/local/bin/rstpep2html.py to 755
        ==> default:   Running setup.py install for rsa
        ==> default:     
        ==> default:     warning: no files found matching 'README'
        ==> default:     Installing pyrsa-encrypt-bigfile script to /usr/local/bin
        ==> default:     Installing pyrsa-encrypt script to /usr/local/bin
        ==> default:     Installing pyrsa-verify script to /usr/local/bin
        ==> default:     Installing pyrsa-sign script to /usr/local/bin
        ==> default:     Installing pyrsa-priv2pub script to /usr/local/bin
        ==> default:     Installing pyrsa-decrypt script to /usr/local/bin
        ==> default:     Installing pyrsa-keygen script to /usr/local/bin
        ==> default:     Installing pyrsa-decrypt-bigfile script to /usr/local/bin
        ==> default:   Found existing installation: requests 2.2.1
        ==> default:     Uninstalling requests:
        ==> default:       Successfully uninstalled requests
        ==> default:   Running setup.py install for jmespath
        ==> default:     changing mode of build/scripts-2.7/jp from 644 to 755
        ==> default:     
        ==> default:     changing mode of /usr/local/bin/jp to 755
        ==> default:   Found existing installation: six 1.5.2
        ==> default:     Uninstalling six:
        ==> default:       Successfully uninstalled six
        ==> default:   Running setup.py install for pyasn1
        ==> default:     
        ==> default: Successfully installed awscli httpie botocore bcdoc docutils rsa Pygments requests jmespath python-dateutil six         pyasn1
        ==> default: Cleaning up...
        ==> default: awscli: aws-cli/1.7.3 Python/2.7.6 Linux/3.13.0-37-generic
        ==> default: python: Python 2.7.6
        ==> default: Reading package lists...
        ==> default: Building dependency tree...
        ==> default: 
        ==> default: Reading state information...
        ==> default: The following NEW packages will be installed:
        ==> default:   iptables-persistent
        ==> default: 0 upgraded, 1 newly installed, 0 to remove and 124 not upgraded.
        ==> default: Need to get 10.2 kB of archives.
        ==> default: After this operation, 62.5 kB of additional disk space will be used.
        ==> default: Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/universe iptables-persistent all 0.5.7 [10.2 kB]
        ==> default: dpkg-preconfigure: unable to re-open stdin: No such file or directory
        ==> default: Fetched 10.2 kB in 0s (45.2 kB/s)
        ==> default: Selecting previously unselected package iptables-persistent.
        ==> default: (Reading database ... 66255 files and directories currently installed.)
        ==> default: Preparing to unpack .../iptables-persistent_0.5.7_all.deb ...
        ==> default:  Removing any system startup links for /etc/init.d/iptables-persistent ...
        ==> default: Unpacking iptables-persistent (0.5.7) ...
        ==> default: Processing triggers for ureadahead (0.100.0-16) ...
        ==> default: Setting up iptables-persistent (0.5.7) ...
        ==> default:  * Loading iptables rules...
        ==> default:  *  IPv4...
        ==> default:  *  IPv6...
        ==> default:    ...done.
        ==> default: Processing triggers for ureadahead (0.100.0-16) ...
        ==> default: =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        ==> default: Dependancy provisioning completed!
        ==> default: =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        ==> default: Running provisioner: shell...
            default: Running: inline script
        ==> default: {:workspace_homedirs=>"/home", :username=>"vagrant", :public_key=>"", :local_ip=>"192.168.50.4", :tenant_number=>        0, :home_dir=>"/home/vagrant"}
        ==> default: Adding TCP port mapping: 192.168.50.4:10080 -> 10.244.10.2:80
        ==> default: Adding TCP port mapping: 192.168.50.4:10443 -> 10.244.10.6:443
        ==> default: =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        ==> default: Workspace for vagrant created!
        ==> default: =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        logsearch-workspace (       3) mrdavidlaing/Dev/logsearch-workspace$ vagrant ssh
        Welcome to Ubuntu 14.04 LTS (GNU/Linux 3.13.0-37-generic x86_64)
        
         * Documentation:  https://help.ubuntu.com/
        +-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+
        |L|o|g|S|e|a|r|c|h| |W|o|r|k|s|p|a|c|e|
        +-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+
        
        ├── bin
        │   └── setup_sub_projects               <--- run this to populate your environments/ and src/ folders
        ├── environments                         <--- configuration for the environments you manage goes here
        │   └── labs-operations                  
        ├── src                                  <--- LogSearch source code goes here
        │   ├── docs
        │   ├── kibana                           
        │   ├── kibana-status-diagram-plugin
        │   ├── logsearch-filters-internal
        │   └── logsearch-website
        
        See the README.md in each sub project for further instructions.
        
        Generating local SSH key
        Loading ENV variables from ~/.env
        Port Mappings:
            192.168.50.4:10080 -> 10.244.10.2:80
            192.168.50.4:10443 -> 10.244.10.6:443
        [logsearch workspace] ~ ▸ cd ~/environments/local/test/
        [logsearch workspace] ~/environments/local/test ▸ bosh upload stemcell https://s3.amazonaws.com/bosh-jenkins-artifacts/bosh-        stemcell/warden/bosh-stemcell-388-warden-boshlite-ubuntu-trusty-go_agent.tgz
        
        Using remote stemcell `https://s3.amazonaws.com/bosh-jenkins-artifacts/bosh-stemcell/warden/bosh-stemcell-388-warden-boshlite-        ubuntu-trusty-go_agent.tgz'
        
        Director task 1
          Started update stemcell
          Started update stemcell > Downloading remote stemcell. Done (00:03:54)
          Started update stemcell > Extracting stemcell archive. Done (00:00:03)
          Started update stemcell > Verifying stemcell manifest. Done (00:00:00)
          Started update stemcell > Checking if this stemcell already exists. Done (00:00:00)
          Started update stemcell > Uploading stemcell bosh-warden-boshlite-ubuntu-trusty-go_agent/388 to the cloud. Done (00:00:13)
          Started update stemcell > Save stemcell bosh-warden-boshlite-ubuntu-trusty-go_agent/388 (d76174e5-923a-4481-5bdc-        57ebaab72149). Done (00:00:00)
             Done update stemcell (00:04:10)
        
        Task 1 done
        
        Started     2015-01-27 09:02:25 UTC
        Finished    2015-01-27 09:06:35 UTC
        Duration    00:04:10
        
        Stemcell uploaded and created.
        [logsearch workspace] ~/environments/local/test ▸  bosh upload release https://s3.amazonaws.com/logsearch-        boshrelease/releases/logsearch-17.tgz
        
        Using remote release `https://s3.amazonaws.com/logsearch-boshrelease/releases/logsearch-17.tgz'
        
        Director task 2
          Started downloading remote release > Downloading remote release. Done (00:01:53)
        
          Started extracting release > Extracting release. Done (00:00:01)
        
          Started verifying manifest > Verifying manifest. Done (00:00:00)
        
          Started resolving package dependencies > Resolving package dependencies. Done (00:00:00)
        
          Started creating new packages
          Started creating new packages > collectd/426c5cb42ff5a326e539aef22f7d14526a02c1be. Done (00:00:00)
          Started creating new packages > elasticsearch/e866cba047ff7ce1f31e3bcfce0762e13c2f47cf. Done (00:00:00)
          Started creating new packages > java7/c04c102fd6c411f867dc44ee65279dd47eb5c8a0. Done (00:00:00)
          Started creating new packages > logstash/5e1a6fd74024db3c4923397f71da1c71a0cb51d3. Done (00:00:01)
          Started creating new packages > logstash-forwarder/2f966c5caa729f165636c69ee9acd2ead524183b. Done (00:00:00)
          Started creating new packages > nginx/07fa264094f0ebb55bcc9990578d9cc159748dc0. Done (00:00:00)
          Started creating new packages > python/356d0ec8645d158e9d1a517c2fd071762d43429d. Done (00:00:00)
          Started creating new packages > redis/cd861700c83a544b6d0bba3b620017d22cf0d726. Done (00:00:01)
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
        
        Started     2015-01-27 09:08:05 UTC
        Finished    2015-01-27 09:10:01 UTC
        Duration    00:01:56
        
        Release uploaded
        [logsearch workspace] ~/environments/local/test ▸ sudo -i /root/shrink_vagrant_box_for_packaging
        umount.nfs: /home/vagrant/environments: device is busy
        umount.nfs: /home/vagrant/environments: device is busy
        Reading package lists... Done
        Building dependency tree       
        Reading state information... Done
        0 upgraded, 0 newly installed, 0 to remove and 124 not upgraded.
        Reading package lists... Done
        Building dependency tree       
        Reading state information... Done
        find: `/var/lib/doc': No such file or directory
        You can ignore: no space left on device errors
        dd: error writing ‘/EMPTY’: No space left on device
        73427+0 records in
        73426+0 records out
        76993482752 bytes (77 GB) copied, 123.93 s, 621 MB/s
        dd: error writing ‘/tmp/whitespace’: No space left on device
        118502+0 records in
        118501+0 records out
        121345024 bytes (121 MB) copied, 0.386957 s, 314 MB/s
        187636+0 records in
        187636+0 records out
        192139264 bytes (192 MB) copied, 0.47333 s, 406 MB/s
        dd: writing to ‘/dev/dm-1’: No space left on device
        2097153+0 records in
        2097152+0 records out
        1073741824 bytes (1.1 GB) copied, 48.3154 s, 22.2 MB/s
        mkswap: /dev/dm-1: warning: don't erase bootbits sectors
                on whole disk. Use -f to force.
        Setting up swapspace version 1, size = 1048572 KiB
        no label, UUID=1ad67f39-e59c-4be0-a0de-81ef57012e00
        [logsearch workspace] ~/environments/local/test ▸ exit
        logout
        Connection to 127.0.0.1 closed.
        logsearch-workspace (       3) mrdavidlaing/Dev/logsearch-workspace$ vagrant package
        ==> default: Attempting graceful shutdown of VM...
        ==> default: Clearing any previously set forwarded ports...
        ==> default: Exporting VM...
        ==> default: Compressing package to: /Users/mrdavidlaing/Dev/logsearch-workspace/package.box
        logsearch-workspace (       4) mrdavidlaing/Dev/logsearch-workspace$ mv package.box logsearch-workspace-201501270921Z.box
        logsearch-workspace (       5) mrdavidlaing/Dev/logsearch-workspace$ ls -lah logsearch-workspace-201501270921Z.box
        -rw-r--r--  1 mrdavidlaing  staff   1.6G 27 Jan 09:19 logsearch-workspace-201501270921Z.box
