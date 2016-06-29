#
# Author:: Hugo Cisneiros (<hugo.cisneiros@movile.com>)
# Cookbook Name:: proftpd-ii
# Recipe:: example_lwrp
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

include_recipe 'proftpd-ii::ldap'
include_recipe 'proftpd-ii::sftp'

proftpd_vhost 'ldap' do
  debug_level 10
  auth_order 'mod_ldap.c'
  ldap true
  ldap_server 'ldap.example.com:389'
  ldap_user_base_dn 'ou=users,dc=example,dc=com'
  ldap_user_filter '(uid=%u)'
  ldap_group_base_dn 'ou=groups,dc=example,dc=com'
  ldap_group_filter '(&(memberUid=%u)(objectclass=posixGroup))'

  options = { 
    'QueryTimeout' => 30,
    'ForceGeneratedHomedir' => 'on'
  }

  ldap_extra_options options
  notifies :restart, 'service[proftpd]', :delayed
end

proftpd_vhost 'sftp' do
  port 2222
  sftp true
  notifies :restart, 'service[proftpd]', :delayed
end
