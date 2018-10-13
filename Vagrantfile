# -*- mode: ruby -*-
# vi: set ft=ruby :

# Use environment variable to define the crypto the first time
# ex for kalkulus:
# MY_CRYPTO='klks' vagrant up
# the you can use #{ENV['MY_CRYPTO']} in vagrantfile
# side note : 
#   use env variable may not be best practice, but simple workaround in this specific context.
#   alternative: use getoption lib https://shakedos.com/passing-vagrant-command-line-parameters


# if not defined, set default
MY_CRYPTO = ENV.has_key?('MY_CRYPTO')? ENV['MY_CRYPTO'] : 'klks'

require 'SecureRandom'
shortid=SecureRandom.hex (2)
# puts shortid
# puts "#{shortid}"
# d=DateTime.now
# d2=d.strftime("%Y_%m_%d_%H_%M_%S")
MN_ALIAS = ENV.has_key?('MN_ALIAS')? ENV['MN_ALIAS'] : "#{MY_CRYPTO}-MN-#{shortid}"

puts MY_CRYPTO
puts MN_ALIAS
puts "#{MN_ALIAS}-controller"

Vagrant.configure(2) do |config|

  # server or desktop ubuntu image
  config.vm.box = "lasp/ubuntu16.04-desktop"
	
  # set default ip
  config.vm.network "private_network", ip: "10.10.15.10"

  # set hostname
  config.vm.hostname = "#{MN_ALIAS}-controller"
	
  # tweak virtualbox
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]    
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", 2]
    vb.name = "#{MN_ALIAS}-controller"
  end	

  # provisioning

  # packages & priv stuff
  # config.vm.provision "shell", :path => "provisioning/packages_setup.sh", privileged: true
  config.vm.provision "shell" do |s|
    s.path = "provisioning/#{MY_CRYPTO}_packages_setup.sh"
    s.args = "#{MY_CRYPTO}"
    s.privileged = true
  end
  
  # wallet & unpriv stuff
  # config.vm.provision :shell, :path => "provisioning/controller_setup.sh", privileged: false
  config.vm.provision "shell" do |s|
    s.path = "provisioning/#{MY_CRYPTO}_controller_setup.sh"
    s.args = "#{MY_CRYPTO}"
    s.privileged = false
  end
  
end
