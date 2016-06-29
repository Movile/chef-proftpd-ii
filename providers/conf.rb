#
# Author:: Hugo Cisneiros (hugo.cisneiros@movile.com)
# Cookbook Name:: proftpd-ii
# Provider:: conf
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

action :enable do
  l = link "#{node['proftpd-ii']['conf_dir']}/conf-enabled/#{new_resource.name}.conf" do
    to "#{node['proftpd-ii']['conf_dir']}/conf-available/#{new_resource.name}.conf"
  end

  # if f is updated, this resource is also updated
  new_resource.updated_by_last_action(l.updated_by_last_action?)
end

action :disable do
  l = link "#{node['proftpd-ii']['conf_dir']}/conf-enabled/#{new_resource.name}.conf" do
    action :delete
  end

  # if f is updated, this resource is also updated
  new_resource.updated_by_last_action(l.updated_by_last_action?)
end
