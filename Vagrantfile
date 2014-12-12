VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.6.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #Ubuntu 14.04 VM with BOSH lite installed
  config.vm.box = 'cloudfoundry/bosh-lite'
  config.vm.box_version = '388'

  config.vm.provider :virtualbox do |v, override| 
    override.vm.network "private_network", ip: "192.168.50.4"
  end

  config.vm.provision "shell", run: "always", inline: <<EOF 
    echo "export AWS_SECRET_ACCESS_KEY=#{ENV['AWS_SECRET_ACCESS_KEY']}
export AWS_ACCESS_KEY_ID=#{ENV['AWS_ACCESS_KEY_ID']}
export GIT_AUTHOR_EMAIL='#{`git config --global user.email`.chomp}'
export GIT_AUTHOR_NAME='#{`git config --global user.name`.chomp}'" > /home/vagrant/.env
EOF

  config.vm.provision "shell", inline: "/vagrant/_setup/runtime/install_dependancies"

  config.vm.provision "shell", inline: <<EOF 
/vagrant/_setup/runtime/add_new_workspace \
  --workspace-homedirs /home \
  --workspace-username vagrant \
  --workspace-public-key '' \
  --workspace-local-ip '192.168.50.4'
EOF

end
