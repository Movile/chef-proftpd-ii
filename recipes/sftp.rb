#
# Author:: Hugo Cisneiros (<hugo.cisneiros@movile.com>)
# Cookbook Name:: proftpd-ii
# Recipe:: sftp
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

include_recipe 'proftpd-ii'

proftpd_module 'sftp' do
end

template "#{node['proftpd-ii']['conf_dir']}/conf-available/sftp.conf" do
  owner node['proftpd-ii']['user']
  group node['proftpd-ii']['group']
  mode 0o640
  source 'sftp.conf.erb'
end
