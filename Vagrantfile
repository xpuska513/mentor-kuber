# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

$provision_script = <<PROVISION
    apt-get -y update
    apt-get install ifupdown -y
PROVISION
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.define "kuber1" do |first|
    first.vm.box = "ubuntu/bionic64"
    first.vm.hostname = "kuber1"
    first.vm.box_url = "ubuntu/bionic64"
    first.vm.network "forwarded_port", guest: 3306, host: 3306
    first.vm.provision "shell", path: "worker.sh"
    config.vm.provision "shell", inline: $provision_script
    first.vm.provider "virtualbox" do |fvb|
      fvb.memory = "2048"
      #first.vm.network "public_network"
      #first.vm.network "private_network", :type => 'dhcp', virutalbox__intnet: 'vboxnet1', :adapter => 2
      first.vm.network "private_network", ip: "172.28.128.25", virutalbox__intnet: 'vboxnet1', :adapter => 2
    end
  end
  config.vm.define "kuber2" do |second|
    second.vm.box = "ubuntu/bionic64"
    second.vm.hostname = "kuber2"
    second.vm.box_url = "ubuntu/bionic64"
    second.vm.network "forwarded_port", guest: 3306, host: 26018
    second.vm.provision "shell", path: "worker.sh"
    config.vm.provision "shell", inline: $provision_script
    second.vm.provider "virtualbox" do |svb|
      svb.memory = "3096"
      #second.vm.network "public_network"
      second.vm.network "private_network", ip: "172.28.128.15", virutalbox__intnet: 'vboxnet1', :adapter => 2
     # second.vm.network "private_network", :type => 'dhcp', virutalbox__intnet: 'vboxnet1', :adapter => 2
    end
  end
  config.vm.define "kuber_test" do |kuber_test|
    kuber_test.vm.box = "ubuntu/bionic64"
    kuber_test.vm.hostname = "kuber"
    kuber_test.vm.box_url = "ubuntu/bionic64"
    kuber_test.vm.network "forwarded_port", guest: 3306, host: 4567
    kuber_test.vm.provision "shell", path: "install.sh"
    config.vm.provision "shell", inline: $provision_script
    kuber_test.vm.provider "virtualbox" do |svb|
        svb.memory = "3096"
        #second.vm.network "public_network"
       # second.vm.network "private_network", :type => 'dhcp', virutalbox__intnet: 'vboxnet1', :adapter => 2
    end
    kuber_test.vm.network "private_network", ip: "172.28.128.18", virutalbox__intnet: 'vboxnet1', :adapter => 2
  end
end
