#
# Author:: Hugo Cisneiros (hugo.cisneiros@movile.com)
# Cookbook Name:: proftpd-ii
# Provider:: module
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

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  f = file "#{node['proftpd-ii']['conf_dir']}/mods-available/#{new_resource.name}.load" do
    owner node['proftpd-ii']['user']
    group node['proftpd-ii']['group']
    mode 0o644
    content "LoadModule mod_#{new_resource.name}.c\n"
  end

  c = template "#{node['proftpd-ii']['conf_dir']}/mods-available/#{new_resource.name}.conf" do
    owner node['proftpd-ii']['user']
    group node['proftpd-ii']['group']
    mode 0o640
    source ["default/mods/#{new_resource.name}.conf.erb", 'default/mods/generic.conf.erb']
  end

  if new_resource.enable
    l = link "#{node['proftpd-ii']['conf_dir']}/mods-enabled/#{new_resource.name}.load" do
      to "#{node['proftpd-ii']['conf_dir']}/mods-available/#{new_resource.name}.load"
    end

    cl = link "#{node['proftpd-ii']['conf_dir']}/mods-enabled/#{new_resource.name}.conf" do
      to "#{node['proftpd-ii']['conf_dir']}/mods-available/#{new_resource.name}.conf"
    end
  else
    l = link "#{node['proftpd-ii']['conf_dir']}/mods-enabled/#{new_resource.name}.load" do
      action :delete
    end

    cl = link "#{node['proftpd-ii']['conf_dir']}/mods-enabled/#{new_resource.name}.conf" do
      action :delete
    end
  end

  # if f is updated, this resource is also updated
  new_resource.updated_by_last_action(f.updated_by_last_action?)
  new_resource.updated_by_last_action(c.updated_by_last_action?)
  new_resource.updated_by_last_action(l.updated_by_last_action?)
  new_resource.updated_by_last_action(cl.updated_by_last_action?)
end

action :delete do
  f = file "#{node['proftpd-ii']['conf_dir']}/mods-available/#{new_resource.name}.load" do
    action :delete
  end

  c = file "#{node['proftpd-ii']['conf_dir']}/mods-available/#{new_resource.name}.conf" do
    action :delete
  end

  l = link "#{node['proftpd-ii']['conf_dir']}/mods-enabled/#{new_resource.name}.load" do
    action :delete
  end

  cl = link "#{node['proftpd-ii']['conf_dir']}/mods-enabled/#{new_resource.name}.conf" do
    action :delete
  end

  # if f is updated, this resource is also updated
  new_resource.updated_by_last_action(f.updated_by_last_action?)
  new_resource.updated_by_last_action(c.updated_by_last_action?)
  new_resource.updated_by_last_action(l.updated_by_last_action?)
  new_resource.updated_by_last_action(cl.updated_by_last_action?)
end
