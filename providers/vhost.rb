#
# Author:: Hugo Cisneiros (hugo.cisneiros@movile.com)
# Cookbook Name:: proftpd-ii
# Provider:: vhost
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
  f = template "#{node['proftpd-ii']['conf_dir']}/sites-available/#{new_resource.name}.conf" do
    owner node['proftpd-ii']['user']
    group node['proftpd-ii']['group']
    mode 0o640
    variables(
      bind: new_resource.bind,
      auth_order: new_resource.auth_order,
      port: new_resource.port,
      default_server: new_resource.default_server,
      default_root: new_resource.default_root,
      debug_level: new_resource.debug_level,
      tls: new_resource.tls,
      tls_required: new_resource.tls_required,
      tls_cert: new_resource.tls_cert,
      tls_key: new_resource.tls_key,
      tls_chain: new_resource.tls_chain,
      tls_verify_client: new_resource.tls_verify_client,
      ldap: new_resource.ldap,
      ldap_use_tls: new_resource.ldap_use_tls,
      ldap_server: new_resource.ldap_server,
      ldap_bind_auth: new_resource.ldap_bind_auth,
      ldap_bind_dn: new_resource.ldap_bind_dn,
      ldap_bind_pass: new_resource.ldap_bind_pass,
      ldap_user_base_dn: new_resource.ldap_user_base_dn,
      ldap_user_filter: new_resource.ldap_user_filter,
      ldap_group_base_dn: new_resource.ldap_group_base_dn,
      ldap_group_filter: new_resource.ldap_group_filter,
      ldap_extra_options: new_resource.ldap_extra_options,
      sftp: new_resource.sftp,
      sftp_userauthorizedkeys: new_resource.sftp_userauthorizedkeys
    )
    cookbook new_resource.cookbook
    source new_resource.template
  end

  if new_resource.enable
    l = link "#{node['proftpd-ii']['conf_dir']}/sites-enabled/#{new_resource.name}.conf" do
      to "#{node['proftpd-ii']['conf_dir']}/sites-available/#{new_resource.name}.conf"
    end
  else
    l = link "#{node['proftpd-ii']['conf_dir']}/sites-enabled/#{new_resource.name}.conf" do
      action :delete
    end
  end

  # if f is updated, this resource is also updated
  new_resource.updated_by_last_action(f.updated_by_last_action?)
  new_resource.updated_by_last_action(l.updated_by_last_action?)
end

action :delete do
  f = file "#{node['proftpd-ii']['conf_dir']}/sites-available/#{new_resource.name}.conf" do
    action :delete
  end

  l = link "#{node['proftpd-ii']['conf_dir']}/sites-enabled/#{new_resource.name}.conf" do
    action :delete
  end

  # if f is updated, this resource is also updated
  new_resource.updated_by_last_action(f.updated_by_last_action?)
  new_resource.updated_by_last_action(l.updated_by_last_action?)
end
