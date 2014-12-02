# better error messages from Hash.fetch
env = ENV.to_hash

# Commands required to setup working docker environment, link containers etc.
$setup = <<SCRIPT
apt-get install apparmor-utils
aa-complain /etc/apparmor.d/docker # prevent error: set apparmor profile docker-default: no such file or directory

# Stop and remove any existing containers
if [ -n "$(docker ps -a -q)" ]; then
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
fi

# Build containers from Dockerfiles
docker build -t bosh-cli /workspace/shared/runtime-environments/bosh-cli
docker build -t kibana /workspace/shared/runtime-environments/kibana/
docker build -t docs-webserver /workspace/shared/runtime-environments/docs/

# Run and link the containers
#docker run -d --name bosh-cli -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker postgres:latest
docker run -d --name docs-webserver -p 8080:80 -v /workspace/docs:/var/www/html docs-webserver

SCRIPT

# Commands required to ensure correct docker containers
# are started when the vm is rebooted.
$start = <<SCRIPT

docker start docs-webserver
SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.6.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = 'logsearch-workspace'

  #VM with BOSH lite installed
  config.vm.box = 'cloudfoundry/bosh-lite'
  config.vm.box_version = '388'

  # Install latest docker
  config.vm.provision "docker"

  # Setup the containers when the VM is first
  # created
  config.vm.provision "shell", inline: $setup

  # Make sure the correct containers are running
  # every time we start the VM.
  config.vm.provision "shell", run: "always", inline: $start

  config.vm.provider :virtualbox do |v, override|
    override.vm.synced_folder ".", "/workspace"
    override.vm.network "private_network", ip: "192.168.50.4"
    override.vm.network :forwarded_port, guest: 8000, host: 8000
    override.vm.network :forwarded_port, guest: 8080, host: 8080
  end

  config.vm.provider :aws do |v, override|

    override.vm.synced_folder ".", "/workspace", type: "rsync", rsync__exclude: [".vagrant/", ".git/"]

    override.ssh.username = 'ubuntu'
    override.ssh.private_key_path = env.fetch('LOGSEARCH_WORKSPACE_PRIVATE_KEY', '~/.ssh/logsearch-workspace.pem')

    v.access_key_id =       env.fetch('AWS_ACCESS_KEY_ID','')
    v.secret_access_key =   env.fetch('AWS_SECRET_ACCESS_KEY','')
    v.region =              env.fetch('AWS_REGION', 'us-east-1')
    v.ami =                 env.fetch('LOGSEARCH_WORKSPACE_AMI', '')
    v.keypair_name =        env.fetch('LOGSEARCH_WORKSPACE_KEYPAIR', 'logsearch-workspace')
    v.block_device_mapping = [{
      :DeviceName => '/dev/sda1',
      'Ebs.VolumeSize' => env.fetch('LOGSEARCH_WORKSPACE_DISK_SIZE', '50').to_i
    }]
    v.instance_type =       env.fetch('LOGSEARCH_WORKSPACE_INSTANCE_TYPE', 'm3.xlarge')
    v.security_groups =     [env.fetch('LOGSEARCH_WORKSPACE_AWS_SECURITY_GROUP_ID', 'logsearch-workspace')]
    v.subnet_id =           env.fetch('LOGSEARCH_WORKSPACE_SUBNET_ID') if env.include?('LOGSEARCH_WORKSPACE_SUBNET_ID')
    v.tags =                { 'Name' => 'logsearch-workspace', 'deployment' => 'logsearch-workspace' }

    meta_data_public_ip_url = "http://169.254.169.254/latest/meta-data/public-ipv4"
    meta_data_local_ip_url = "http://169.254.169.254/latest/meta-data/local-ipv4"

    $PUBLIC_IP2 = <<PUBLIC_IP_SCRIPT
public_ip_http_code=`curl -s -o /dev/null -w "%{http_code}" #{meta_data_public_ip_url}`

if [ $public_ip_http_code == "404" ]; then
  local_ip=`curl -s #{meta_data_local_ip_url}`
  echo "There is no public IP for this instance"
  echo "The private IP for this instance is $local_ip"
else
  public_ip=`curl -s #{meta_data_public_ip_url}`
  echo "The public IP for this instance is $public_ip"
fi
PUBLIC_IP_SCRIPT

    config.vm.provision :shell, id: "public_ip", run: "always", inline: $PUBLIC_IP2

    $PORT_FORWARDING2 = <<IP_SCRIPT
local_ip=`curl -s #{meta_data_local_ip_url}`
echo "Setting up port forwarding for the LogSearch..."
sudo iptables -t nat -A PREROUTING -p tcp -d $local_ip --dport 80 -j DNAT --to 10.244.2.2:80
sudo iptables -t nat -A PREROUTING -p tcp -d $local_ip --dport 443 -j DNAT --to 10.244.2.14:443
IP_SCRIPT
    config.vm.provision :shell, id: "port_forwarding", run: "always", inline: $PORT_FORWARDING2

  end

end
