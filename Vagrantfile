# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # server or desktop
  #config.vm.box = "ubuntu/xenial64"
  config.vm.box = "fso/xenial64-desktop"
	
  # set default ip
  config.vm.network "private_network", ip: "10.10.15.10"

  # set hostname
  config.vm.hostname = "klks-controller"	
	
  # tweak virtualbox
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]    
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", 2]
    vb.name = "klks-controller"
  end	

  # packages & priv stuff
  config.vm.provision :shell, :path => "provisioning/packages_setup.sh", privileged: true
  # provisioning

  # wallet & unrpiv stuff
  config.vm.provision :shell, :path => "provisioning/controller_setup.sh", privileged: false
  # provisioning  
	
end
