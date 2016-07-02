# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.provider 'docker' do |docker|
    docker.build_dir = '.'
    docker.has_ssh = true
    docker.ports = [ '5521:21', '5621:2121', '5522:2222' ]
    docker.dockerfile = 'Dockerfile.centos6'
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
