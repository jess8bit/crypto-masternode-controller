# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # if not defined, set default
  CRYPTO_CODE = 'gincoin'
  SHORT_ID = '001'
  VM_NAME = "#{CRYPTO_CODE}-controller-#{SHORT_ID}"
  VM_HOSTNAME = VM_NAME
  
  # server or desktop ubuntu image
  config.vm.box = "lasp/ubuntu16.04-desktop"
	
  # set default ip
  config.vm.network "private_network", ip: "10.10.15.10"

  # set hostname
  config.vm.hostname = "#{VM_HOSTNAME}"
	
  # tweak virtualbox
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]    
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", 2]
    vb.name = "#{VM_NAME}"
  end	

  # provisioning

  # packages & priv stuff
  # config.vm.provision "shell", :path => "provisioning/packages_setup.sh", privileged: true
  config.vm.provision "shell" do |s|
    s.path = "provisioning/#{CRYPTO_CODE}_packages_setup.sh"
    s.args = "#{CRYPTO_CODE}"
    s.privileged = true
  end
  
  # wallet & unpriv stuff
  # config.vm.provision :shell, :path => "provisioning/controller_setup.sh", privileged: false
  config.vm.provision "shell" do |s|
    s.path = "provisioning/#{CRYPTO_CODE}_controller_setup.sh"
    s.args = "#{CRYPTO_CODE}"
    s.privileged = false
  end
  
end
