# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "centos/7"
  
  
  config.vm.define "master" do |master|
    master.vm.network "forwarded_port", guest: 8443, host: 8543
	master.vm.network "forwarded_port", guest: 8080, host: 8580
	master.vm.network "forwarded_port", guest: 443, host: 8553
	master.vm.network "private_network", ip: "192.168.33.10"
	
    master.vm.provider "virtualbox" do |vb|	
	  if ARGV[0] == "up" && ! File.exist?("./masterdocker.vdi")
	    vb.customize [
	     "createhd",
	     "--filename", "./masterdocker.vdi",
	     "--format", "VDI",
	     "--size", "4096"
	    ]
	  
	  vb.customize [
	    "storageattach", :id,
	    "--storagectl", "IDE",
	    "--port", "1",
	    "--device", "0",
	    "--type", "hdd",
	    "--medium", "./masterdocker.vdi"
	  ]
	  
	  end
	  
	  vb.memory = "1024"
	end

    master.vm.provision "shell", path: "master.sh"
  end
  
  config.vm.define "node" do |node|
    node.vm.network "forwarded_port", guest: 8443, host: 8544
	node.vm.network "forwarded_port", guest: 8080, host: 8581
	node.vm.network "private_network", ip: "192.168.33.11"
	
	node.vm.provider "virtualbox" do |vb|
	  if ARGV[0] == "up" && ! File.exist?("./nodedocker.vdi")
	    vb.customize [
	     "createhd",
	     "--filename", "./nodedocker.vdi",
	     "--format", "VDI",
	     "--size", "4096"
	    ]

	  
	  vb.customize [
	    "storageattach", :id,
	    "--storagectl", "IDE",
	    "--port", "1",
	    "--device", "0",
	    "--type", "hdd",
	    "--medium", "./nodedocker.vdi"
	  ]
	  end
	  vb.memory = "1024"
	end
	
	node.vm.provision "shell", path: "node.sh"
	
  end
	
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  #config.vm.provider "virtualbox" do |vb|
  #  # Display the VirtualBox GUI when booting the machine
  #  # vb.gui = true
  #  # Customize the amount of memory on the VM:
  #  vb.memory = "1024"
  #end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
