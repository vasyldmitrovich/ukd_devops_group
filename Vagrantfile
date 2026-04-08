# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  # Set config to machine machine1
  config.vm.define "machine1" do |m1|
    m1.vm.box = "generic/ubuntu2204"
    m1.vm.network "private_network", ip: "192.168.56.10"
    m1.vm.hostname = "machine"
    m1.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
    
    m1.vm.provision "shell", inline: "sudo apt update"
  end
end
