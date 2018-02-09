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

# NOTE: Many of these configuration directives are detailed explained
# at the ProFTPd's documentation. See:
# http://www.proftpd.org/docs/

# Configuration directory root. All configuration will be under this
# directory
default['proftpd-ii']['conf_dir'] = '/etc/proftpd'

# Log directory root. All logs will be created under this directory.
default['proftpd-ii']['log_dir'] = '/var/log/proftpd'

# Modules directory root. Modules will be loaded from this directory.
default['proftpd-ii']['mods_dir'] = '/usr/libexec/proftpd'

if node['platform_version'].to_i == 7
  # Where the proftpd.score file is located
  default['proftpd-ii']['scoreboard_file'] = '/var/run/proftpd/proftpd.score'
  # Where the PID file for the daemon is located
  default['proftpd-ii']['pid_file'] = '/var/run/proftpd/proftpd.pid'
else
  default['proftpd-ii']['pid_file'] = '/var/run/proftpd.pid'
  default['proftpd-ii']['scoreboard_file'] = '/var/run/proftpd.score'
end

# User and group for running the daemon
default['proftpd-ii']['user'] = 'proftpd'
default['proftpd-ii']['group'] = 'proftpd'

# Home directory and shell for the daemon user
default['proftpd-ii']['user_dir'] = '/var/lib/ftp'
default['proftpd-ii']['user_shell'] = '/sbin/nologin'

# What modules will we configure and load?
default['proftpd-ii']['basic_modules'] = %w()
default['proftpd-ii']['extra_modules'] = %w()

# When a client connects, how do we name ourselves?
default['proftpd-ii']['server_name'] = 'ProFTPD server'

# Email from the server admin
default['proftpd-ii']['server_admin'] = 'ftpmaster@example.com'

# When a client logins, what do we show?
default['proftpd-ii']['server_indent'] = false

# Don't show welcome message until user has authenticated
default['proftpd-ii']['defer_welcome'] = true

# Number of max instances of proftpd running. Useful for limiting
# connections to the daemon and preventing DDoS.
default['proftpd-ii']['max_instances'] = 30

# Default port the daemon will use to listen for connections
default['proftpd-ii']['port'] = 21

# Port range the server will announce when the client uses passive mode
default['proftpd-ii']['passive_ports'] = '49152 65534'

# If using the server behind NAT, you can specify the real address here,
# so the server can report itself to the client correctly.
default['proftpd-ii']['nat'] = false

# Ident lookups and reverse DNS lookups when the client connects to the
# server. Disabled by default for performance.
default['proftpd-ii']['ident_lookups'] = false
default['proftpd-ii']['reverse_dns'] = false

# How many login errors a client can do before the server disconnects it.
default['proftpd-ii']['max_login_attempts'] = 3

# Do we allow Server-to-Server transfers (FXP)?
default['proftpd-ii']['fxp'] = false

# The authentication module order. ProFTPd will look at each authentication
# module and try using the defined order. See ProFTPd's documentation for
# more detailed info. 
default['proftpd-ii']['auth_order'] = 'mod_auth_pam.c mod_auth_unix.c'

# Do we allow root logins?
default['proftpd-ii']['root_login'] = false

# Do we present a password prompt after connecting? If not, client has to
# provide immediately at the connection.
default['proftpd-ii']['login_password_prompt'] = true

# Limits the connections per client machine (Integer)
default['proftpd-ii']['max_clients_host'] = false

# Users can only login if they have a valid shell configured. The valid
# shells list are based on /etc/shells file.
default['proftpd-ii']['require_valid_shell'] = true

# Timeout on stalled data transfers (seconds)
default['proftpd-ii']['timeout_stalled'] = 3600

# Connection without transfer timeout (seconds)
default['proftpd-ii']['timeout_no_transfer'] = 300

# Idle connection timeout (seconds)
default['proftpd-ii']['timeout_idle'] = 600

# Allow download resume?
default['proftpd-ii']['retrieve_restart'] = true

# Allow upload resume?
default['proftpd-ii']['retrieve_store'] = true

# What is the root directory when a user logins? Defaults to the home
# directory of the user (besides the adm account). See ProFTPd's
# documentation for more info.
default['proftpd-ii']['default_root'] = '~ !adm'

# If the user doesn't have a home directory, should we create it for them?
# Specify the skel-like dir and options if needed. See
# http://www.proftpd.org/docs/directives/linked/config_ref_CreateHome.html
# for more details.
default['proftpd-ii']['create_home'] = false

# umask for permissions used when the user uploads new files.
default['proftpd-ii']['umask'] = '022'

# What options do we append to the list directory command? Defaults to
# showing hidden files (ls -a)
default['proftpd-ii']['list_options'] = '-a'

# RFC2228 multiline response mode
default['proftpd-ii']['rfc2228'] = false

# Default log format 
default['proftpd-ii']['log_format_default'] = '%h %l %u %t \"%r\" %s %b'

# Authentication log format
default['proftpd-ii']['log_format_auth'] = '%v [%P] %h %t \"%r\" %s'

# Debug Level for the daemon
default['proftpd-ii']['debug_level'] = 0

# What ciphers will TLS use when negotiating with the client
default['proftpd-ii']['tls_ciphers'] = 'ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:-SSLv2:+EXP'

# use an user authorized keys file to permit users to login using keys
default['proftpd-ii']['sftp_userauthorizedkeys'] = nil
