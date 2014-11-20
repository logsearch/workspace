# Adapted from http://www.talkingquickly.co.uk/2014/06/rails-development-environment-with-vagrant-and-docker/

# Commands required to setup working docker environment, link containers etc.
$setup = <<SCRIPT
# Stop and remove any existing containers
if [ -n "$(docker ps -a -q)" ]; then
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
fi

# Build containers from Dockerfiles
docker build -t bosh-cli /workspace/shared/runtime-environments/bosh-cli
docker build -t kibana /workspace/shared/runtime-environments/kibana/

# Run and link the containers
#docker run -d --name bosh-cli -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker postgres:latest

SCRIPT

# Commands required to ensure correct docker containers
# are started when the vm is rebooted.
$start = <<SCRIPT
#docker start bosh-cli

SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.6.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #Baby Vagrant VM with docker 1.3.1
  config.vm.define "boot2docker"
  config.vm.box = "yungsang/boot2docker"

  # Install latest docker
  config.vm.provision "docker"

  # need a private network for NFS shares to work
  config.vm.network "private_network", ip: "192.168.50.4"

  config.vm.synced_folder ".", "/workspace"

  # Uncomment below to use more than one instance at once
  config.vm.network :forwarded_port, guest: 8000, host: 8000

  # Fix busybox/udhcpc issue
  config.vm.provision :shell do |s|
    s.inline = <<-EOT
      if ! grep -qs ^nameserver /etc/resolv.conf; then
        sudo /sbin/udhcpc
      fi
      cat /etc/resolv.conf
    EOT
  end

  # Adjust datetime after suspend and resume
  config.vm.provision :shell do |s|
    s.inline = <<-EOT
      sudo /usr/local/bin/ntpclient -s -h pool.ntp.org
      date
    EOT
  end

  # Setup the containers when the VM is first
  # created
  config.vm.provision "shell", inline: $setup

  # Make sure the correct containers are running
  # every time we start the VM.
  config.vm.provision "shell", run: "always", inline: $start

end
