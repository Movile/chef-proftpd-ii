#
# Author:: Hugo Cisneiros (hugo.cisneiros@movile.com)
# Cookbook Name:: proftpd-ii
# Resource:: vhost
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
provides :proftpd_vhost
actions :create, :delete
default_action :create

attribute :bind,              kind_of: String,                  default: '0.0.0.0'
attribute :port,              kind_of: Integer,                 default: node['proftpd-ii']['port']
attribute :auth_order,        kind_of: String,                  default: node['proftpd-ii']['auth_order']
attribute :default_server,    kind_of: [TrueClass, FalseClass], default: false

attribute :enable,            kind_of: [TrueClass, FalseClass], default: true
attribute :cookbook,          kind_of: String,                  default: 'proftpd-ii'
attribute :template,          kind_of: String,                  default: 'vhost.conf.erb'
attribute :default_root,      kind_of: String,                  default: node['proftpd-ii']['default_root']

attribute :log_dir,           kind_of: String,                  default: node['proftpd-ii']['log_dir']
attribute :debug_level,       kind_of: Integer,                 default: node['proftpd-ii']['debug_level']

attribute :tls,               kind_of: [TrueClass, FalseClass], default: false
attribute :tls_required,      kind_of: [TrueClass, FalseClass], default: true
attribute :tls_cert,          kind_of: String,                  default: nil
attribute :tls_key,           kind_of: String,                  default: nil
attribute :tls_chain,         kind_of: String,                  default: nil
attribute :tls_verify_client, kind_of: [TrueClass, FalseClass], default: false

attribute :ldap,              kind_of: [TrueClass, FalseClass], default: false
attribute :ldap_use_tls,      kind_of: [TrueClass, FalseClass], default: true
attribute :ldap_server,       kind_of: String,                  default: nil
attribute :ldap_bind_auth,    kind_of: [TrueClass, FalseClass], default: false
attribute :ldap_bind_dn,      kind_of: String,                  default: nil
attribute :ldap_bind_pass,    kind_of: String,                  default: nil
attribute :ldap_user_base_dn, kind_of: String,                  default: nil
attribute :ldap_user_filter,  kind_of: String,                  default: nil
attribute :ldap_group_base_dn, kind_of: String, default: nil
attribute :ldap_group_filter, kind_of: String, default: nil
attribute :ldap_extra_options, kind_of: Hash, default: {}

attribute :sftp,              kind_of: [TrueClass, FalseClass], default: false
attribute :sftp_userauthorizedkeys, kind_of: String, default: nil

attr_accessor :exists
