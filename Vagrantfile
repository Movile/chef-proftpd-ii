# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.provider "docker" do |d|
    d.build_dir = "."
    d.has_ssh = true
  end

  config.omnibus.chef_version = '12.5.1'
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "proftpd-ii::example_lwrp"
    chef.log_level = :info
    chef.formatter = 'doc'
    chef.json = {
    }
  end
end
