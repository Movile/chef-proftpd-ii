# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # docker is fast
  config.vm.provider 'docker' do |docker|
    docker.build_dir = '.'
    docker.has_ssh = true
  end

  # one vm per supported distribution
  config.vm.define 'centos6' do |centos6|
    centos6.vm.hostname = 'centos6'
    centos6.vm.provider 'docker' do |docker|
      docker.dockerfile = 'Dockerfile.centos6'
      docker.ports = [ '6521:21', '6621:2121', '6522:2222' ]
    end
  end

  tempdir = Dir.mktmpdir
  config.vm.define 'centos7' do |centos7|
    centos7.vm.hostname = 'centos7'
    centos7.vm.provider 'docker' do |docker|
      docker.dockerfile = 'Dockerfile.centos7'
      docker.ports = [ '7521:21', '7621:2121', '7522:2222' ]
      docker.volumes = [ '/sys/fs/cgroup:/sys/fs/cgroup:ro', "#{tempdir}:/run" ]
    end
  end

  # specific chef version
  config.omnibus.chef_version = '12.5.1'

  # run the example recipe
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "proftpd-ii::example_lwrp"
    chef.log_level = :info
    chef.formatter = 'doc'
    chef.json = {
    }
  end
end
