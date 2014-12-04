# better error messages from Hash.fetch
env = ENV.to_hash

VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.6.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = 'logsearch-workspace'

  #Ubuntu 14.04 VM with BOSH lite installed
  config.vm.box = 'cloudfoundry/bosh-lite'
  config.vm.box_version = '388'

  config.vm.provision "shell", path: "_setup/ubuntu/install_dependancies"
  config.vm.provision :file, source: '~/.gitconfig', destination: '/home/vagrant/.gitconfig' if File.exist?(ENV['HOME'] + '/.gitconfig')

  config.vm.provider :virtualbox do |v, override|
    override.vm.synced_folder ".", "/vagrant"
    override.vm.network "private_network", ip: "192.168.50.4"
    override.vm.network :forwarded_port, guest: 8000, host: 8000
    override.vm.network :forwarded_port, guest: 8080, host: 8080
  end

end
