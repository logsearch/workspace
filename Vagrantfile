require 'fileutils'
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.6.5"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #Ubuntu 14.04 VM with BOSH lite installed (used to create a new logsearch-workspace box from scratch via 'vagrant package')
  #config.vm.box = 'cloudfoundry/bosh-lite'
  #config.vm.box_version = '388'
  #Provisioned LogSearch workspace (created from 'cloudfoundry/bosh-lite' via 'vagrant package', see above)
  config.vm.box = 'logsearch-workspace-201501270921Z'
  config.vm.box_url = 'https://s3-eu-west-1.amazonaws.com/ci-logsearch/vagrant/boxes/logsearch-workspace-201501270921Z.box'
  config.vm.hostname = 'logsearch-workspace'

  config.vm.provider :virtualbox do |v, override| 
    config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=777"] # ensure any VM user can create files in subfolders - eg, /vagrant/tmp
    override.vm.network "private_network", ip: "192.168.50.4"
   
    #Ensure workspace shares exist on host
    FileUtils.mkdir_p('workspace/environments') unless File.exists?('workspace/environments')
    FileUtils.mkdir_p('workspace/src') unless File.exists?('workspace/src')
    #Enable NFS folder sharing if on Mac
    if RUBY_PLATFORM =~ /.*darwin.*/ 
      override.vm.synced_folder "workspace/environments", "/home/vagrant/environments", type: "nfs"
      override.vm.synced_folder "workspace/src", "/home/vagrant/src", type: "nfs"
    end
    #Enable folder sharing if on Windows
    if RUBY_PLATFORM =~ /.*mswin|windows|mingw|cygwin.*/
      # enable symlinks http://stackoverflow.com/questions/24200333/symbolic-links-and-synced-folders-in-vagrant
      v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
      override.vm.synced_folder "workspace/environments", "/home/vagrant/environments", mount_options: ["dmode=777"]
      override.vm.synced_folder "workspace/src", "/home/vagrant/src", mount_options: ["dmode=777"]
    end

  end

  config.vm.provision "shell", run: "always", inline: <<EOF 
    echo "export AWS_ACCESS_KEY_ID=#{ENV['AWS_ACCESS_KEY_ID']}
export AWS_SECRET_ACCESS_KEY=#{ENV['AWS_SECRET_ACCESS_KEY']}
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
