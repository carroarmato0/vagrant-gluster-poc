# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "https://dumps.carroarmato0.be/vagrantboxes/centos-6.6-64b-puppet-vbox.box"

  storage01_extra_disk = '/tmp/storage01_extra_disk.vdi'
  storage02_extra_disk = '/tmp/storage02_extra_disk.vdi'

  config.vm.define "storage01" do |storage01|
    storage01.vm.provider "virtualbox" do |v|
      unless File.exist?(storage01_extra_disk)
        v.customize ['createhd', '--filename', storage01_extra_disk, '--size', 500 * 1024]
      end
      v.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', storage01_extra_disk]
    end
    storage01.vm.hostname = "storage01.local"
    storage01.vm.network "private_network", ip: "192.168.33.11"
  end

  config.vm.define "storage02" do |storage02|
    storage02.vm.provider "virtualbox" do |v|
      unless File.exist?(storage02_extra_disk)
        v.customize ['createhd', '--filename', storage02_extra_disk, '--size', 500 * 1024]
      end
      v.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', storage02_extra_disk]
    end
    storage02.vm.hostname = "storage02.local"
    storage02.vm.network "private_network", ip: "192.168.33.12"
  end

  config.vm.define "client01" do |client01|
    client01.vm.hostname = "client01.local"
    client01.vm.network "private_network", ip: "192.168.33.21"
  end

  config.vm.define "client02" do |client02|
    client02.vm.hostname = "client02.local"
    client02.vm.network "private_network", ip: "192.168.33.22"
  end

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path     = "manifests"
    puppet.manifest_file      = "site.pp"
    puppet.module_path        = "modules"
    puppet.hiera_config_path  = "hiera.yaml"
    #puppet.options = "--verbose --debug"
   end

end
