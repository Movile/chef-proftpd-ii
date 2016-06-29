#
# Author:: Hugo Cisneiros (hugo.cisneiros@movile.com)
# Cookbook Name:: proftpd-ii
# Attributes:: default
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

# daemon directories and files
default['proftpd-ii']['conf_dir'] = '/etc/proftpd'
default['proftpd-ii']['log_dir'] = '/var/log/proftpd'
default['proftpd-ii']['mods_dir'] = '/usr/libexec/proftpd'
default['proftpd-ii']['scoreboard_file'] = '/var/run/proftpd.score'
default['proftpd-ii']['pid_file'] = '/var/run/proftpd.pid'

# user and group for running the daemon
default['proftpd-ii']['user'] = 'proftpd'
default['proftpd-ii']['group'] = 'proftpd'

# home directory and shell for the daemon user
default['proftpd-ii']['user_dir'] = '/var/lib/ftp'
default['proftpd-ii']['user_shell'] = '/sbin/nologin'

# modules definitions
default['proftpd-ii']['basic_modules'] = %w()
default['proftpd-ii']['extra_modules'] = %w()

# banner info
default['proftpd-ii']['server_name'] = 'ProFTPD server'
default['proftpd-ii']['server_admin'] = 'ftpmaster@example.com'
default['proftpd-ii']['server_indent'] = false
default['proftpd-ii']['defer_welcome'] = true

# connection
default['proftpd-ii']['max_instances'] = 30
default['proftpd-ii']['port'] = 21
default['proftpd-ii']['passive_ports'] = '49152 65534'
default['proftpd-ii']['nat'] = false
default['proftpd-ii']['ident_lookups'] = false
default['proftpd-ii']['reverse_dns'] = false
default['proftpd-ii']['max_login_attempts'] = 3
default['proftpd-ii']['fxp'] = false

# login
default['proftpd-ii']['auth_order'] = 'mod_auth_pam.c mod_auth_unix.c'
default['proftpd-ii']['root_login'] = false
default['proftpd-ii']['login_password_prompt'] = true
default['proftpd-ii']['max_clients_host'] = false
default['proftpd-ii']['require_valid_shell'] = true

# transfers
default['proftpd-ii']['timeout_stalled'] = 3600
default['proftpd-ii']['timeout_no_transfer'] = 300
default['proftpd-ii']['timeout_idle'] = 600
default['proftpd-ii']['retrieve_restart'] = true
default['proftpd-ii']['retrieve_store'] = true

# files and directories
default['proftpd-ii']['default_root'] = '~ !adm'
default['proftpd-ii']['umask'] = '022'
default['proftpd-ii']['list_options'] = '-a'
default['proftpd-ii']['rfc2228'] = false

# logging
default['proftpd-ii']['log_format_default'] = '%h %l %u %t \"%r\" %s %b'
default['proftpd-ii']['log_format_auth'] = '%v [%P] %h %t \"%r\" %s'
default['proftpd-ii']['debug_level'] = 0

# tls
default['proftpd-ii']['tls_ciphers'] = 'ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:-SSLv2:+EXP'
