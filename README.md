proftpd-ii Cookbook
===================

Installs and configures ProFTPd Server (http://www.proftpd.org/) and some of
its modules. It also setups configuration like Apache's scripts (
(eg. `sites-available/`sites-enabled`).

It provides an LWRP for easily deploying virtualhosts. It's recommended to
always use a vhost configuration instead of the default, global configuration.

The latest and greatest revision of this cookbook will always be available
at https://github.com/Movile/chef-proftpd-ii

Requirements
============

Cookbooks
---------

The following cookbooks are dependencies for this:

* yum-repoforge - needed to install RPM packages for proftpd.

Platform
--------

The following platforms are supported and tested:

* CentOS 6.7
* CentOS 7.2

Chef Server
-----------

The recommended chef version is at least >= 11.0

Usage
=====

To use the cookbook, you can just add the `default` recipe to the run_list. It
will install and configure the daemon. Then you can use attributes or LWRPs to
configure custom values and virtual hosts.

## Helper Recipes

* `ldap.rb` installs the LDAP module, enables it and provides a sample
configuration.

* `sftp.rb` installs the sFTP module, enables it and provides a sample
configuration.

* `example\_lwrp.rb` provides some examples on using the LWRP resources.

Attributes
==========

Attributes are documented on `attributes/default.rb` file. This way I don't need
to duplicate definitions here and there :)

LWRP
====

## vhost

This cookbook includes `proftpd\_vhost` LWRP which facilitates creating a new
virtual host. It also contains support for using `notifies`, so you can notify
the server to reload after some configuration changes.

For example, to use the `proftpd\_vhost`:

```ruby
# install first
include_recipe 'proftpd-ii'

# a normal ftp site
proftpd_vhost 'ftp' do
  enable true
  port 21
  notifies :restart, 'service[proftpd]', :delayed
end

# a tls and ldap-enabled site
proftpd_vhost 'ldap' do
  port 990
  debug_level 10
  auth_order 'mod_ldap.c'

  tls true
  tls_required true
  tls_cert /etc/proftpd/ssl/proftpd.crt.pem
  tls_key /etc/proftpd/ssl/proftpd.key.pem

  ldap true
  ldap_use_tls true
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

# sftp, if module enabled
proftpd_vhost 'sftp' do
  port 2222
  sftp true
  notifies :restart, 'service[proftpd]', :delayed
end
```

If you want to configure but not enable the virtual host, you can use
`enable false` on the LWRP definition.

## module

Enables a module in the configuration.

It creates a `LoadModule` directive and puts it on `mods-enabled` directory.
For example, enabling some custom modules:

```ruby
proftpd_module 'ldap'
proftpd_module 'sftp'
``` 

License and Author
==================

- Author:: Hugo Cisneiros (<hugo.cisneiros@movile.com>)

Copyright 2016, Movile

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
