# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "https://dumps.carroarmato0.be/vagrantboxes/centos-6.6-64b-puppet-vbox.box"

  config.vm.define "storage01" do |storage01|
  	config.vm.hostname = "storage01"
    storage01.vm.network "private_network", ip: "192.168.33.1"
  end

  config.vm.define "storage02" do |storage02|
  	storage02.vm.hostname = "storage02"
    storage02.vm.network "private_network", ip: "192.168.33.2"
  end

  config.vm.define "client01" do |client01|
  	client01.vm.hostname = "client01"
    client01.vm.network "private_network", ip: "192.168.33.11"
  end

  config.vm.define "client02" do |client02|
  	client02.vm.hostname = "client02"
    client02.vm.network "private_network", ip: "192.168.33.12"
  end

  config.vm.provision "puppet" do |puppet|
		puppet.manifests_path 		= "manifests"
		puppet.manifest_file  		= "site.pp"
		puppet.module_path  			= "modules"
		puppet.hiera_config_path  = "hiera.yaml"
#     puppet.options = "--verbose --debug"
   end

end
