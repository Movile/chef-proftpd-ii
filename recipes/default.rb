#
# Author:: Hugo Cisneiros (<hugo.cisneiros@movile.com>)
# Cookbook Name:: proftpd-ii
# Recipe:: default
#
# Copyright 2016, Movile
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# install repository and basic package
case node['platform_family']
when 'rhel'
  include_recipe 'yum-repoforge'
end

package 'proftpd'

# modules and packages
if node['proftpd-ii']['extra_modules'].include?('ldap')
  include_recipe 'proftpd-ii::ldap'
end

# special user and group
group node['proftpd-ii']['group'] do
  system true
end

user node['proftpd-ii']['user'] do
  system true
  gid node['proftpd-ii']['group']
  supports :manage_home => false
  home node['proftpd-ii']['user_dir']
  shell node['proftpd-ii']['user_shell']
end

# directories
directory node['proftpd-ii']['conf_dir'] do
  owner node['proftpd-ii']['user']
  group node['proftpd-ii']['group']
  mode 0755
end

directory "#{node['proftpd-ii']['conf_dir']}/ssl" do
  owner node['proftpd-ii']['user']
  group node['proftpd-ii']['group']
  mode 0700
end

%w(conf sites mods).each do |dir|
  directory "#{node['proftpd-ii']['conf_dir']}/#{dir}-available" do
    owner node['proftpd-ii']['user']
    group node['proftpd-ii']['group']
    mode 0755
  end

  directory "#{node['proftpd-ii']['conf_dir']}/#{dir}-enabled" do
    owner node['proftpd-ii']['user']
    group node['proftpd-ii']['group']
    mode 0755
  end
end

directory node['proftpd-ii']['log_dir'] do
  owner node['proftpd-ii']['user']
  group node['proftpd-ii']['group']
  mode 0755
end

link "#{node['proftpd-ii']['conf_dir']}/logs" do
  to node['proftpd-ii']['log_dir']
end

directory node['proftpd-ii']['user_dir'] do
  owner node['proftpd-ii']['user']
  group node['proftpd-ii']['group']
  mode 0700
end

# configuration
template "#{node['proftpd-ii']['conf_dir']}/proftpd.conf" do
  owner node['proftpd-ii']['user']
  group node['proftpd-ii']['group']
  mode 0640
  source 'proftpd.conf.erb'
  notifies :reload, 'service[proftpd]', :delayed
end

link "/etc/proftpd.conf" do
  to "#{node['proftpd-ii']['conf_dir']}/proftpd.conf"
end

cookbook_file "#{node['proftpd-ii']['conf_dir']}/conf-available/global.conf" do
  owner node['proftpd-ii']['user']
  group node['proftpd-ii']['group']
  mode 0640
  source 'global.conf'
end

template "#{node['proftpd-ii']['conf_dir']}/conf-available/tls.conf" do
  owner node['proftpd-ii']['user']
  group node['proftpd-ii']['group']
  mode 0640
  source 'tls.conf.erb'
end

# service
service 'proftpd' do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end
